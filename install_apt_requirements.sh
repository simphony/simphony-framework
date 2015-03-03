#!/bin/bash
sh -c "echo deb http://www.openfoam.org/download/ubuntu precise main > /etc/apt
apt-get update -qq
apt-get install build-essential git libhdf5-serial-dev mpi-default-bin mpi-default-dev python-pip python-virtualenv
apt-get install -y --force-yes openfoam222
