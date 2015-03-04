#!/bin/bash
set -e

virtualenv ~/simphony
source ~/simphony/bin/activate

pip --version
pip install simphony_packages.txt
