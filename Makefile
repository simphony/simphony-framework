# Makefile for Simphony Framework
# You can set these variables from the command line.
SIMPHONYENV   ?= $(HOME)/simphony
# end 

UBUNTU_CODENAME=$(shell lsb_release -cs)

SIMPHONY_METAPARSER_VERSION ?= master
SIMPHONY_METATOOLS_VERSION ?= master
SIMPHONY_COMMON_VERSION ?= master

# Path for MPI in HDF5 suport
MPI_INCLUDE_PATH ?= /usr/include/mpi

.PHONY: clean \
		base \
		apt-simphony-deps \
		fix-pip \
		simphony-env \
		simphony \
		simphony-common \
		test-plugins \
		test-framework \
		test-simphony 

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo " deps                 to install the dependencies (requires sudo)"
	@echo "  base                 to install essential packages (requires sudo)"
	@echo "  apt-simphony-deps    to install building depedencies for the simphony library (requires sudo)"
	@echo "  fix-pip              to update the version of pip and virtual evn (requires sudo)"
	@echo " venv-prepare          to create a simphony virtualenv"
	@echo "  simphony-venv        to install the solvers"
	@echo " simphony             to build and install the simphony framework"
	@echo "  simphony-common      to build and install the simphony-common package"
	@echo " simphony-mayavi      to build and install the simphony-mayavi plugin"
	@echo " simphony-paraview    to build and install the simphony-paraview plugin"
	@echo " test-framework       run the tests for the simphony-framework"
	@echo "  test-plugins         run the tests for all the simphony-plugins"
	@echo "   test-simphony        run the tests for the simphony library"
	@echo " clean                remove any temporary folders"

clean:
	@echo
	@echo "Removed temporary folders"

deps: base apt-simphony-deps

venv-prepare: simphony-env solvers

solvers: 

simphony: simphony-common 
	@echo
	@echo "Simphony plugins installed"

test-plugins: test-simphony 
	@echo
	@echo "Tests for simphony plugins done"

test-framework: test-plugins
	@echo
	@echo "Tests for the simphony framework done"


# ----------------------
# Individual rules

base:
	apt-get install -y --force-yes software-properties-common apt-transport-https python-software-properties
	add-apt-repository ppa:git-core/ppa -y
	apt-get update -qq
	apt-get install -y --force-yes build-essential git subversion

apt-simphony-deps:
ifeq ($(UBUNTU_CODENAME),precise)
	apt-get install -y --force-yes libhdf5-serial-1.8.4 libhdf5-serial-dev
else ifeq ($(UBUNTU_CODENAME),trusty)
	apt-get install -y --force-yes libhdf5-7 libhdf5-dev
else
	$(error "Unrecognized ubuntu version $(UBUNTU_CODENAME)")
endif
	apt-get install -y --force-yes python-dev libatlas-dev libatlas3gf-base
	@echo
	@echo "Build dependencies for simphony installed"

fix-pip:
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py
	rm get-pip.py
	pip install --upgrade setuptools
	pip install --upgrade virtualenv
	@echo
	pip --version
	@echo "Latest pip installed"

simphony-env:
	rm -rf $(SIMPHONYENV)
	virtualenv $(SIMPHONYENV) --system-site-packages
	# Put the site-packages as well. some .so files from liggghts end up there.
	echo "export LD_LIBRARY_PATH=$(SIMPHONYENV)/lib:$(SIMPHONYENV)/lib/python2.7/site-packages/:$(SIMPHONYENV)/lib/kratos/python2.7/site-packages/:\$$LD_LIBRARY_PATH" >> "$(SIMPHONYENV)/bin/activate"
ifeq ($(USE_OPENFOAM_PARAVIEW),yes)
	echo "export LD_LIBRARY_PATH=$(SIMPHONYENV)/lib:/opt/paraviewopenfoam410/lib/paraview-4.1:\$$LD_LIBRARY_PATH\n" >> "$(SIMPHONYENV)/bin/activate"
	echo "export PYTHONPATH=/opt/paraviewopenfoam410/lib/paraview-4.1/site-packages/:/opt/paraviewopenfoam410/lib/paraview-4.1/site-packages/vtk:\$$PYTHONPATH" >> "$(SIMPHONYENV)/bin/activate"
endif
	echo "export PYTHONPATH=$(SIMPHONYENV)/lib/kratos/python2.7/site-packages/:\$$PYTHONPATH" >> "$(SIMPHONYENV)/bin/activate"
	echo ". /opt/openfoam$(OPENFOAM_VERSION)/etc/bashrc" >> "$(SIMPHONYENV)/bin/activate"
	@echo
	@echo "Simphony virtualenv created"

simphony-metaparser:
	pip install git+https://github.com/simphony/simphony-metaparser.git@$(SIMPHONY_METAPARSER_VERSION)#egg=simphony_metaparser
	@echo
	@echo "Simphony metaparser installed"

simphony-metatools: simphony-metaparser
	pip install git+https://github.com/simphony/simphony-metatools.git@$(SIMPHONY_METATOOLS_VERSION)#egg=simphony_metatools
	@echo
	@echo "Simphony metatools installed"

simphony-common: simphony-metatools
	pip install git+https://github.com/simphony/simphony-common.git@$(SIMPHONY_COMMON_VERSION)#egg=simphony
	@echo
	@echo "Simphony library installed"

test-simphony:
	haas simphony -v
	@echo
	@echo "Tests for simphony library done"

test-integration:
	haas tests/ -v
	@echo
	@echo "Integration tests for the simphony framework done"
