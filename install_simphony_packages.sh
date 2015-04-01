#!/bin/bash
set -e

pip --version
# (1) Install numexpr externally because the requirements do not
#     work with them
pip install "numexpr>=2.0.0"
pip install -r requirements.txt
pip install -r simphony_packages.txt
