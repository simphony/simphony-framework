\# This Dockerfile creates a complete SimPhoNy environment.

# The base image
FROM ubuntu:12.04

MAINTAINER SimPhoNy Team

# Make assume-yes permanent. Having this, there is no need to change scripts.
# Update the os and install dev requirements afterwards
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90forceyes && \
  apt-get update && apt-get install --yes \
    build-essential \
    git \
    python-software-properties \
    wget \
# Clone simphony-frameowork and start building
&& git clone https://github.com/simphony/simphony-framework.git

WORKDIR /simphony-framework

RUN make base 		\
  apt-openfoam-deps 	\
  apt-simphony-deps 	\
  apt-lammps-deps 	\
  apt-mayavi-deps 	\
  apt-aviz-deps 	\
# Load openfoam environment at startup
&& echo '. /opt/openfoam222/etc/bashrc' >> ~/.bashrc

# Intall latest version of pip and virtualenv and solvers
RUN make	\
  fix-pip 	\
  simphony-env 	\
  lammps 	\
  jyu-lb 	\
  kratos 	\
  numerrin 	\
  aviz

# Install simphony
RUN make 	\
  simphony 	\
  simphony-plugins

# This sets up the `user` directory
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/user && \
    echo "user:x:${uid}:${gid}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/user

USER user
ENV HOME /home/user

# To run the docker image with bash shell
# docker run -it simphony bash

# If you want to launch Qt4-base application (e.g. Mayavi2)
# Run docker with added arguments
# docker run -it --rm -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix simphony bash

# You can also launch the Mayavi2 application straight away
# docker run -it --rm -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix simphony mayavi2
