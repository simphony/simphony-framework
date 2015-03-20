#!/bin/bash
set -e

pip --version
pip install numexpr
pip install -r requirements.txt
pip install -r simphony_packages.txt
