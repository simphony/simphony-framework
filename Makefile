# Makefile for Simphony Framework
# You can set these variables from the command line.
SIMPHONYENV   ?= $(HOME)/simphony
# end 

UBUNTU_CODENAME=$(shell lsb_release -cs)

SIMPHONY_METAPARSER_VERSION ?= master
SIMPHONY_METATOOLS_VERSION ?= master
SIMPHONY_COMMON_VERSION ?= master
SIMPHONY_OPENFOAM_VERSION ?= master

# Path for MPI in HDF5 suport
MPI_INCLUDE_PATH ?= /usr/include/mpi

OPENFOAM_VERSION=231

.PHONY: clean \
        provision \
		base \
		apt-simphony-deps \
		apt-openfoam-deps \
		fix-pip \
		simphony-env \
		simphony \
		simphony-common \
		simphony-openfoam \
		test-plugins \
		test-framework \
		test-openfoam \
		test-simphony 

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo " provision            to install the dependencies (requires sudo)"
	@echo " venv                 to create a simphony virtualenv"
	@echo " simphony             to build and install the simphony framework"
	@echo " test                 run the tests for the simphony-framework"
	@echo " clean                remove any temporary folders"

clean:
	@echo
	@echo "Removed temporary folders"

provision: base apt-simphony-deps apt-openfoam-deps

venv: simphony-env solvers

solvers: 

simphony: simphony-common simphony-openfoam
	@echo
	@echo "Simphony plugins installed"

test-plugins: test-simphony 
	@echo
	@echo "Tests for simphony plugins done"

test: test-plugins
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

apt-openfoam-deps:
ifeq ($(UBUNTU_CODENAME),precise)
	echo "deb http://dl.openfoam.org/ubuntu precise main" > /etc/apt/sources.list.d/openfoam.list
	add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ precise multiverse"
else ifeq ($(UBUNTU_CODENAME),trusty)
	echo "deb http://dl.openfoam.org/ubuntu trusty main" > /etc/apt/sources.list.d/openfoam.list
else
	$(error "Unrecognized ubuntu version $(UBUNTU_CODENAME)")
endif
	wget -O - http://dl.openfoam.org/gpg.key | apt-key add -
	apt-get update -qq
ifeq ($(UBUNTU_CODENAME),precise)
	apt-get install -y libcgal8 libcgal-dev
endif
	apt-get install -y --force-yes openfoam$(OPENFOAM_VERSION)
	@echo
	@echo "Openfoam installed use . /opt/openfoam$(OPENFOAM_VERSION)/etc/bashrc to setup the environment"

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
	echo "export LD_LIBRARY_PATH=$(SIMPHONYENV)/lib:$(SIMPHONYENV)/lib/python2.7/site-packages/:\$$LD_LIBRARY_PATH" >> "$(SIMPHONYENV)/bin/activate"
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

simphony-openfoam:
	rm -Rf src/simphony-openfoam
	(mkdir -p src/simphony-openfoam/pyfoam; wget https://openfoamwiki.net/images/3/3b/PyFoam-0.6.4.tar.gz -O src/simphony-openfoam/pyfoam/pyfoam.tgz --no-check-certificate)
	tar -xzf src/simphony-openfoam/pyfoam/pyfoam.tgz -C src/simphony-openfoam/pyfoam
	(pip install src/simphony-openfoam/pyfoam/PyFoam-0.6.4; rm -Rf src/simphony-openfoam/pyfoam)
	pip install git+https://github.com/simphony/simphony-openfoam.git@$(SIMPHONY_OPENFOAM_VERSION)#egg=foam_wrappers
	@echo "Simphony OpenFoam plugin installed"

test-openfoam:
	haas foam_controlwrapper foam_internalwrapper -v
	@echo
	@echo "Tests for the openfoam plugin done"

test-simphony:
	haas simphony -v
	@echo
	@echo "Tests for simphony library done"

