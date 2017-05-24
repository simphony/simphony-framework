SimPhoNy Framework
==================

The SimPhoNy Framework is a meta-package to simplify integration and testing
of the SimPhoNy simulation tools. The framework is build around the simphony
library and the SimPhoNy plugins.


.. image:: https://travis-ci.org/simphony/simphony-framework.svg?branch=master
    :target: https://travis-ci.org/simphony/simphony-framework

Packages
--------

The simphony-common version that is supported in version 0.3.3 of the framework is:

- https://github.com/simphony/simphony-common/releases/tag/0.4.1, version 0.4.1

The SimPhoNy plugins that are compatible with this release:
are:

- https://github.com/simphony/simphony-jyulb/releases/tag/0.2.0, version 0.2.0
- https://github.com/simphony/simphony-lammps-md/releases/tag/0.1.5, version 0.1.5
- https://github.com/simphony/simphony-openfoam/releases/tag/0.1.5, version 0.1.5
- https://github.com/simphony/simphony-numerrin/releases/tag/0.1.1, version 0.1.1
- https://github.com/simphony/simphony-kratos/releases/tag/0.2.0, version 0.2.0
- https://github.com/simphony/simphony-mayavi/releases/tag/0.4.1, version 0.4.1
- https://github.com/simphony/simphony-aviz/releases/tag/0.2.0, version 0.1.0
- https://github.com/simphony/simphony-paraview/releases/tag/0.2.0, version 0.2.0

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

  The SymPhoNy framework is developed and tested on Ubuntu 12.04 LTS
  64bit and Ubuntu 14.04.
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

  sudo make prepare 

Install the appropriate dependencies for the UI package you plan to install
(either mayavi or paraview). The two are incompatible in deployment.
To install Mayavi::

  sudo make apt-mayavi-deps

If you are installing paraview, use the ``apt-paraview-deps`` instead.


Setup virtual environment and solvers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is recommended that the simphony framework is installed in a python
virtual environment to avoid contaminating the system python
with the simphony packages and allow a simpler user installation.
The resulting activation script also exports all the variables
needed to successfully run the programs.

The following make command builds the virtual environment::

  make venv-prepare

It also installs solvers that are not available as deb packages 
and need to be built locally.

.. note::

   The ``numerrin`` target will install the numerrin library. To use this solver, please
   ensure that environment variable PYNUMERRIN_LICENSE points to a valid Numerrin
   license file.

which will create a virtual enviroment in ``~/simphony`` or::

  SIMPHONYENV=<path> make venv

Activate the environment::

  source ~/simphony/bin/activate


Install Simphony
~~~~~~~~~~~~~~~~

Finally, install the complete framework with::

  make simphony simphony-mayavi

.. note::

   - ``simphony-paraview`` can be used in place of ``simphony-mayavi``
	 to install paraview.

   - ``simphony-paraview`` can be setup to use the system (default) or
     openfoam build of Paraview using the ``USE_OPENFOAM_PARAVIEW``
     enviroment variable

Complete build
--------------

::
	sudo make prepare apt-mayavi-deps
	make solvers
	make venv
	source ~/simphony/bin/activate
	make simphony simphony-mayavi

Test
----

::

   make test-framework

.. note::

   The testing of simphony-numerrin is only performed if the environement variable
   HAVE_NUMERRIN is set to yes (i.e. ''HAVE_NUMERRIN=yes make test-framework'')

Summary of releases
-------------------

=====================  =======  ======= ========
 Repository                     Version
---------------------  -------------------------
 simphony-framework     0.1.3    0.2.2    0.3.0
=====================  =======  =======  =======
 simphony-common        0.1.3    0.2.2    0.2.2
 simphony-jyulb         0.1.3    0.2.0    0.2.0
 simphony-kratos        0.1.1    0.2.0    0.2.0
 simphony-lammps-md     0.1.3    0.1.5    0.1.5
 simphony-openfoam      0.1.3    0.1.5    0.1.5
 simphony-numerrin      0.1.0    0.1.1    0.1.1
 simphony-mayavi        0.1.1    0.3.1    0.4.1
 simphony-aviz           n/a     0.1.0    0.2.0
 simphony-paraview       n/a      n/a     0.2.0
=====================  =======  =======  =======
