SimPhoNy Framework
==================

**NOTE**: THIS REPOSITORY IS LEGACY. The future direction is to build packages
with EDM. See repository simphony/buildrecipes-common for more details.

The SimPhoNy Framework is a meta-package to simplify integration and testing
of the SimPhoNy simulation tools. The framework is build around the simphony
library and the SimPhoNy plugins.


.. image:: https://travis-ci.org/simphony/simphony-framework.svg?branch=master
    :target: https://travis-ci.org/simphony/simphony-framework

Packages
--------

The simphony-common version that is supported in master of the framework is:

- https://github.com/simphony/simphony-common/
- https://github.com/simphony/simphony-openfoam/

Repository
----------

The repository is hosted in github::

  https://github.com/simphony/simphony-framework


License
-------

The SimPhoNy Framework repository code and scripts are governed by the BSD license
(see LICENSE.txt). The various dependencies, however, have their own licensing
condition please make sure that you agree and comply with the license of the
components that will be installed.


Installation
------------

Checkout the simphony-framework repo::

  git clone https://github.com/simphony/simphony-framework.git
  cd simphony-framework

.. note::

  The SymPhoNy framework is developed and tested on Ubuntu 14.04.
  The following commands and included scripts assume that they
  are executed inside the top level directory of the simphony-framework
  cloned repository.

Makefile
~~~~~~~~

To build and install the various parts of simphony framework a Makefile is provided.
Running ``make help`` list all the available targets.


Installing build dependencies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All these targets make sure that the necessary libraries are installed by the
various apt repositories, and require ``sudo`` access::

  sudo make provision

Setup virtual environment and solvers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is recommended that the simphony framework is installed in a python
virtual environment to avoid contaminating the system python
with the simphony packages and allow a simpler user installation.
The resulting activation script also exports all the variables
needed to successfully run the programs.

The following make command builds the virtual environment::

  make venv

It also installs solvers that are not available as deb packages 
and need to be built locally.

The command will create a virtual enviroment in ``~/simphony``.
Activate the environment with::

  source ~/simphony/bin/activate

Install Simphony
~~~~~~~~~~~~~~~~

Finally, install the complete framework with::

  make simphony

Complete build
--------------

::
	sudo make deps
	make venv
	source ~/simphony/bin/activate
	make simphony 

Test
----

::

   make test

Summary of releases
-------------------

=====================  =======  =======  =======  =======  ========
 Repository                     Version
---------------------  --------------------------------------------
 simphony-framework     0.1.3    0.2.2    0.3.0    0.3.3    master
=====================  =======  =======  =======  =======  ========
 simphony-common        0.1.3    0.2.2    0.2.2    0.4.1    master 
 simphony-jyulb         0.1.3    0.2.0    0.2.0    0.2.1     n/a
 simphony-kratos        0.1.1    0.2.0    0.2.0    0.2.1     n/a
 simphony-lammps-md     0.1.3    0.1.5    0.1.5    0.1.5     n/a
 simphony-openfoam      0.1.3    0.1.5    0.1.5    0.2.4    master
 simphony-numerrin      0.1.0    0.1.1    0.1.1    0.1.3     n/a
 simphony-mayavi        0.1.1    0.3.1    0.4.1    0.4.3     n/a 
 simphony-aviz           n/a     0.1.0    0.2.0    0.2.2     n/a
 simphony-paraview       n/a      n/a     0.2.0    0.2.1     n/a
 simphony-liggghts       n/a      n/a      n/a     0.1.6     n/a 
=====================  =======  =======  =======  =======  ========
