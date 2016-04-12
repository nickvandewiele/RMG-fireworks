#!/bin/bash

set -e

target=$1

# clone RMG-tests:
git clone https://github.com/ReactionMechanismGenerator/RMG-tests.git
cp RMG-tests/examples/rmg/$1/*.py .

RMG=$2
echo "test version of RMG: "$RMG

source activate benchmark

bm=benchmark
testmod=testmodel
echo 'benchmark model folder: '$bm
echo 'Test model folder: '$testmod

# check generated models:
# core:
PYTHONPATH=$RMG:$PYTHONPATH python $RMG/scripts/checkModels.py $target $bm/chemkin/chem_annotated.inp $bm/chemkin/species_dictionary.txt $testmod/chemkin/chem_annotated.inp $testmod/chemkin/species_dictionary.txt

echo core for $target:
if grep "checkModels" $target.log | cut -f2- -d'=' > $target.core ; then
	cat $target.core
	rm $target.core
fi

# edge:
PYTHONPATH=$RMG:$PYTHONPATH python $RMG/scripts/checkModels.py $target $bm/chemkin/chem_edge_annotated.inp $bm/chemkin/species_edge_dictionary.txt $testmod/chemkin/chem_edge_annotated.inp $testmod/chemkin/species_edge_dictionary.txt
echo edge for $target:
if grep "checkModels" $target.log | cut -f2- -d'=' > $target.edge ; then
	cat $target.edge
	rm $target.edge
fi

echo 'Execution time, Benchmark:'
grep "Execution time" $bm/RMG.log | tail -1
echo 'Execution time, Tested:'
grep "Execution time" $testmod/RMG.log | tail -1

echo 'Memory used, Benchmark:'
grep "Memory used:" $bm/RMG.log | tail -1
echo 'Memory used, Tested:'
grep "Memory used:" $testmod/RMG.log | tail -1

# regression testing
REGR=regression_input.py
if [ -f "$REGR" ];
then
	PYTHONPATH=$RMG:$PYTHONPATH python $RMG/rmgpy/tools/regression.py $REGR $bm/chemkin $testmod/chemkin/
else
	echo "Regression input file not found. Not running a regression test."
fi
