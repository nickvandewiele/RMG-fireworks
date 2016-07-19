#!/bin/bash

set -e

# benchmark versions
RMG_VERSION="1.0.4"
DB_VERSION="1.1.0"

rm -rf RMG-Py RMG-database

# use $DB_VERSION of RMG-database:
git clone -b $DB_VERSION --single-branch https://github.com/ReactionMechanismGenerator/RMG-database.git

# clone entire RMG-Py:
git clone https://github.com/ReactionMechanismGenerator/RMG-Py.git

cd RMG-Py
conda create --name tested --clone rmg_env

# set the RMG environment variable and add RMG-Py path to $PYTHONPATH:
RMG=`pwd`
echo "test version of RMG: "$RMG

source activate tested
PYTHONPATH=$RMG:$PYTHONPATH make
source deactivate