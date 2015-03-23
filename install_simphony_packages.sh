#!/bin/bash
set -e

source ~/simphony/bin/activate
pip --version
# (1) Install numexpr externally because the requirements do not
#     work with them
pip install numexpr
pip install -r requirements.txt
pip install -r simphony_packages.txt
