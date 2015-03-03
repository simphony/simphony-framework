#!/bin/bash
echo deb http://www.openfoam.org/download/ubuntu precise main > /etc/apt/sources.list.d/openfoam.list
apt-get update -qq
apt-get install -y build-essential git libhdf5-serial-dev mpi-default-bin mpi-default-dev python-pip python-virtualenv
apt-get install -y --force-yes openfoam222
