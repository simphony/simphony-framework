SimPhoNy Framework
==================

The Simphony Framework is a meta-package to simplify integration and testing
of the Simphony simulation tools.

Repository
----------

The repository is hosted in github::

  https://github.com/simphony/simphony-framework

License
-------

The Simphony Framework repository code and scripts are governed by the BSD license
(see LICENSE.txt). The various dependencies, however, have their own licensing
condition please make sure that you agree and comply with the license of the
components that will be installed.

Installation
------------


Checkout the simphony-framework repo::

  git clone git@github.com:simphony/simphony-framework.git
  cd simphony-framework

.. note::

  The SymPhoNy framework is developed and tested on Ubuntu 12.04 LTS
  and the following commands and included scripts assume that they
  are executed inside the top level directory of the simphony-framework
  cloned repository.


Apt packages
~~~~~~~~~~~~

To build and install the simphony framework the  following apt repos are required::

  sudo sh -c "echo deb http://www.openfoam.org/download/ubuntu precise main > /etc/apt
  sudo apt-get update

The following packages are required::

  sudo apt-get install build-essential git subversion
  sudo apt-get install libhdf5-serial-dev
  sudo apt-get install mpi-default-bin mpi-default-dev
  sudo apt-get install python-dev python-pip python-virtualenv
  sudo apt-get install -y --force-yes openfoam222


External packages
~~~~~~~~~~~~~~~~~

A number of dependencies are not available through `apt` and we will need to
compile them from sources.


Create a python virtual environment and activate it::

  virtualenv ~/simphony
  source ~/simphony/bin/activate

.. note::

   It is advised that the simphony framework is installed in a python virtual
   environment to avoid contaminating the system python with packages and
   allow a simpler user installation.

- Install **lammps-md**
::

  git clone git://git.lammps.org/lammps-ro.git lammps
  # checkout a recent stable version (from 9 Dec 2014)
  pushd lammps
  git checkout r12824
  cd src
  make ubuntu_simple
  ln -s $(pwd)/lmp_ubuntu_simple ~/simphony/bin/lammps
  popd

- Install **JYU-LB**
::

  git clone https://github.com/simphony/JYU-LB.git
  pushd JYU-LB
  make
  ln -s $(pwd)/bin/jyu_lb_isothermal3D.exe ~/simphony/bin/jyu_lb_isothermal3D.exe
  popd

- Install **PyFoam**
::

  svn co https://svn.code.sf.net/p/openfoam-extend/svn/trunk/Breeder/other/scripting/PyFoam
  pushd PyFoam
  python setup.py install
  popd

Simphony packages
~~~~~~~~~~~~~~~~~

The simpony packages that are compatible with this release of the SimPhony Framework
are:

- simphony-common, version 0.1.1
- simphony-jyulb, version 0.1.1
- simphony-lammps-md, version 0.1.1
- simphony-openfoam, version 0.1.0

To install the SimPhoNy components one needs to run the following commands::

  source ~/simphony/bin/activate # optional we just need to make sure that we use the simphony virtualenv
  pip install numexpr cython==0.20
  pip install -r requirements.txt
  pip install -r simphony_packages.txt

Installation scripts
~~~~~~~~~~~~~~~~~~~~

A set of simple installation scripts are also provided that execute the above commands
in sequence::

  sudo ./install_apt_requirements.sh
  virtualenv ~/simphony --system-site-packages
  source ~/simphony/bin/activate
  ./install_external.sh
  ./install_simphony_packages.sh

Usage
~~~~~

To activate the SimPhoNy environment::

  . /opt/openfoam222/etc/bashrc
  . ~/simphony/bin/activate

To tests the different simphony libraries::

  - haas simphony
  - haas jyulb
  - haas simlammps
