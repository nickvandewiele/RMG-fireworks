#!/bin/bash

set -e

TARGET=$1

# clone RMG-tests:
git clone https://github.com/ReactionMechanismGenerator/RMG-tests.git
cp RMG-tests/examples/rmg/$1/*.py .

RMG=$2
echo "test version of RMG: "$RMG

INP=input.py

echo "Running $1 example"

# activate benchmark environment:
source activate tested

# make folder for models generated by the test version of RMG-Py and RMG-database:
mkdir -p testmodel
rm -rf testmodel/*
cp $INP testmodel/

echo "Generating model with tested version of RMG-Py..."
PYTHONPATH=$RMG:$PYTHONPATH python $RMG/rmg.py testmodel/$INP > /dev/null
