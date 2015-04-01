#!/bin/bash
set -e

# Install lammps-md
git clone git://git.lammps.org/lammps-ro.git lammps
# checkout a recent stable version (from 9 Dec 2014)
pushd lammps
git checkout r12824
cd src
make -j 2 ubuntu_simple
ln -s $(pwd)/lmp_ubuntu_simple $VIRTUAL_ENV/bin/lammps
popd

# Install JYU-LB
git clone https://github.com/simphony/JYU-LB.git
git clechout e006f2f05
pushd JYU-LB
make -j 2
ln -s $(pwd)/bin/jyu_lb_isothermal3D.exe $VIRTUAL_ENV/bin/jyu_lb_isothermal3D.exe
popd

# install PyFoam
svn co https://svn.code.sf.net/p/openfoam-extend/svn/trunk/Breeder/other/scripting/PyFoam
pushd PyFoam
python setup.py install
popd
