SimPhoNy Framework
==================

The Simphony Framework is a meta-package to simplify integration and testing
of the Simphony simulation tools.

Repository
----------

The repository is hosted in github::

  https://github.com/simphony/simphony-framework


Installation
------------


Checkout the simphony-framework repo::

  git clone git@github.com:simphony/simphony-framework.git
  cd simphony-framework

.. note::

  The SymPhoNy framework is developed and tested on Ubuntu 12.4 LTS
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
  sudo apt-get install python-pip python-virtualenv
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

- Install **lammps-md**::

  git clone git://git.lammps.org/lammps-ro.git lammps
  # checkout a recent stable version (from 9 Dec 2014)
  cd lammps
  git checkout r12824
  cd src
  make ubuntu_simple
  ln -s lmp_ubuntu_simple ~/simphony/bin/lammps
  cd ../..

- Install **JYU-LB**::

  git clone https://github.com/simphony/JYU-LB.git
  cd JYU-LB
  make
  ln -s ./bin/jyu_lb_isotherma3D.exe ~/simphony/bin/jyu_lb_isotherma3D.exe
  cd ..

- Install **PyFoam**::

  svn co https://svn.code.sf.net/p/openfoam-extend/svn/trunk/Breeder/other/scripting/PyFoam
  cd PyFoam
  python setup.py install


Installation scripts
~~~~~~~~~~~~~~~~~~~~

A set of simple installation scripts are also provided that execute the above commands
in sequence::


  sudo ./install_apt_requirements.sh
  ./install_external
  ./install_simphony_packages
