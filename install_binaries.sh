#!/bin/bash

set -e

# benchmark versions
RMG_VERSION="1.0.4"
DB_VERSION="1.1.0"

# create benchmark binaries of RMG-Py and RMG-database in the "benchmark" environment
conda env remove --name benchmark -y
conda create -c rmg --name benchmark rmg=$RMG_VERSION rmgdatabase=$DB_VERSION -y