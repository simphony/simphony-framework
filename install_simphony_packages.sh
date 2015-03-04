#!/bin/bash
set -e

source ~/simphony/bin/activate

pip --version
# (1) Install cython and numexpr externally because the requirements does
#     work with them
# (2) Pytables breaks with latest Cython
#     see https://github.com/PyTables/PyTables/issues/388
pip install numexpr cython==0.20
pip install -r requirements.txt
pip install -r simphony_packages.txt
