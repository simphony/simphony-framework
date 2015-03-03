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


.. note::

  The SymPhoNy framework is developed and tested on Ubuntu 12.4 LTS
  and the following commands and included scripts running on an Ubuntu
  machine.


Apt packages
~~~~~~~~~~~~

To build and install the simphony framework the  following apt repos are required::

  sudo sh -c "echo deb http://www.openfoam.org/download/ubuntu precise main > /etc/apt

The following packages are required::

  sudo apt-get install build-essential git
  sudo apt-get install libhdf5-serial-dev
  sudo apt-get install mpi-default-bin mpi-default-dev
  sudo apt-get install python-pip python-virtualenv
  sudo apt-get install -y --force-yes openfoam222


of you can run::

  sudo ./install_apt_requirements.sh


Then create a python virtual environment and activate it::

  virtualenv ~/simphony
  source ~/simphony/bin/activate

.. note::

   It is advised that the simphony framework is installed in a virtual enviroment
   to avoid contaminating the system python with packages and allow a simple
   user installation.
