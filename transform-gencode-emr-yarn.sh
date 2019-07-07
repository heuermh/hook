#!/bin/bash

#
# EMR cluster with:
# 16 vCPUs 30G RAM master and core nodes (m3.2xlarge)
DRIVER_MEMORY="20G"
DRIVER_CORES="14"
EXECUTOR_MEMORY="20G"
EXECUTOR_CORES="14"

ADAM="adam-submit --master yarn --deploy-mode cluster --driver-memory $DRIVER_MEMORY --executor-memory $EXECUTOR_MEMORY --conf spark.driver.cores=$DRIVER_CORES --conf spark.executor.cores=$EXECUTOR_CORES --conf spark.executor.memoryOverhead=2048 --conf spark.kryoserializer.buffer.max=2046 --"

echo ">>> transforming genome and primary assembly"

time $ADAM transformSlices -maximum_length 10000 -create_reference GRCh38.p12.genome.fa.gz GRCh38.p12.genome.10k.slices.adam
time $ADAM transformSlices -maximum_length 10000 -create_reference GRCh38.primary_assembly.genome.fa.gz GRCh38.primary_assembly.genome.10k.slices.adam

echo ">>> transforming transcripts and proteins"

time $ADAM transformSequences -alphabet DNA gencode.v31.transcripts.fa.gz gencode.v31.transcripts.sequences.adam
time $ADAM transformSequences -alphabet PROTEIN pc_translations.fa.gz pc_translations.sequences.adam

echo ">>> transforming features"

time $ADAM transformFeatures -reference GRCh38.p12.genome.fa.dict gencode.v31.annotation.gff3.gz gencode.v31.annotation.features.adam
time $ADAM transformFeatures -reference GRCh38.p12.genome.fa.dict gencode.v31.chr_patch_hapl_scaff.annotation.gff3.gz gencode.v31.chr_patch_hapl_scaff.annotation.features.adam
time $ADAM transformFeatures -reference GRCh38.primary_assembly.genome.fa.dict gencode.v31.primary_assembly.annotation.gff3.gz gencode.v31.primary_assembly.annotation.features.adam

echo ">>> done"
