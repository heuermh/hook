#!/bin/bash

set -x

ADAM="adam-submit"

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
