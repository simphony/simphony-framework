# This Dockerfile creates a complete SimPhoNy environment.

# The base image
FROM ubuntu:12.04

MAINTAINER SimPhoNy Team

# Make assume-yes permanent. Having this, there is no need to change scripts.
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90forceyes

# Update the os
RUN apt-get update && apt-get upgrade --yes

# Install dev requirments
RUN apt-get install build-essential git python-software-properties wget -y

# Clone simphony-frameowork
RUN git clone https://github.com/simphony/simphony-framework.git

# Install necessary libraries
RUN /bin/bash -c "cd simphony-framework; make base"
RUN /bin/bash -c "cd simphony-framework; make apt-openfoam-deps"
RUN /bin/bash -c "cd simphony-framework; make apt-simphony-deps"
RUN /bin/bash -c "cd simphony-framework; make apt-lammps-deps"
RUN /bin/bash -c "cd simphony-framework; make apt-mayavi-deps"
RUN /bin/bash -c "cd simphony-framework; make apt-aviz-deps"

# Intall latest version of pip and virtualenv
RUN /bin/bash -c "cd simphony-framework; make fix-pip; make simphony-env"

# Install solvers
RUN /bin/bash -c "cd simphony-framework; make -j 2 lammps"
RUN /bin/bash -c "cd simphony-framework; make -j 2 jyu-lb"
RUN /bin/bash -c "cd simphony-framework; make kratos"
RUN /bin/bash -c "cd simphony-framework; make numerrin"
RUN /bin/bash -c "cd simphony-framework; make aviz"

# Install simphony
RUN /bin/bash -c "cd simphony-framework; make simphony"
RUN /bin/bash -c "cd simphony-framework; make simphony-plugins"

# Load openfoam environment at startup
RUN echo '. /opt/openfoam222/etc/bashrc' >> ~/.bashrc
