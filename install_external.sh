#!/bin/bash
set -e

virtualenv ~/simphony
source ~/simphony/bin/activate


# Install lammps-md
git clone --depth=1 git://git.lammps.org/lammps-ro.git lammps
# checkout a recent stable version (from 9 Dec 2014)
cd lammps
git fetch tags
git checkout r12824
cd src
make ubuntu_simple
ln -s lmp_ubuntu_simple ~/simphony/bin/lammps
cd ../..

# Install JYU-LB
git clone https://github.com/simphony/JYU-LB.git
cd JYU-LB
make
ln -s ./bin/jyu_lb_isotherma3D.exe ~/simphony/bin/jyu_lb_isotherma3D.exe
cd ..

# install PyFoam
svn co https://svn.code.sf.net/p/openfoam-extend/svn/trunk/Breeder/other/scripting/PyFoam
cd PyFoam
python setup.py install
cd ..
