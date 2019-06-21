#!/bin/bash

#
# EMR cluster with:
# 16 vCPUs 30G RAM master and core nodes (m3.2xlarge)
DRIVER_MEMORY="20G"
DRIVER_CORES="14"
EXECUTOR_MEMORY="20G"
EXECUTOR_CORES="14"

ADAM="./bin/adam-submit --master yarn --deploy-mode cluster --driver-memory $DRIVER_MEMORY --executor-memory $EXECUTOR_MEMORY --conf spark.driver.cores=$DRIVER_CORES --conf spark.executor.cores=$EXECUTOR_CORES --conf spark.executor.memoryOverhead=2048 --conf spark.kryoserializer.buffer.max=2046 --"

echo ">>> transforming proteins and coding sequences"

time $ADAM transformSequences -alphabet PROTEIN bowhead_whale_proteins.fasta.gz bowhead_whale_proteins.sequences.adam
time $ADAM transformSequences -alphabet DNA bowhead_whale_coding_sequences.fasta.gz bowhead_whale_coding_sequences.sequences.adam


echo ">>> transforming scaffolds to sequences and slices"

time $ADAM transformSequences -alphabet DNA bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.sequences.adam
time $ADAM transformSequences -alphabet DNA -create_reference bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.ref.sequences.adam
time $ADAM transformSlices -maximum_length 10000 bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.10k.slices.adam
time $ADAM transformSlices -maximum_length 10000 -create_reference bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.ref.10k.slices.adam
time $ADAM transformSlices -maximum_length 100000 bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.100k.slices.adam
time $ADAM transformSlices -maximum_length 100000 -create_reference bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.ref.100k.slices.adam


echo ">>> transforming Trinity sequences to sequences"

time $ADAM transformSequences -alphabet DNA Bickham_Trinity.fasta.gz Bickham_Trinity.sequences.adam
time $ADAM transformSequences -alphabet DNA -create_reference Bickham_Trinity.fasta.gz Bickham_Trinity.ref.sequences.adam
time $ADAM transformSequences -alphabet DNA Bo_bowhead_MusKid_TrinityFasta.fasta.gz Bo_bowhead_MusKid_TrinityFasta.sequences.adam
time $ADAM transformSequences -alphabet DNA -create_reference Bo_bowhead_MusKid_TrinityFasta.fasta.gz Bo_bowhead_MusKid_TrinityFasta.ref.sequences.adam

echo ">>> done"
