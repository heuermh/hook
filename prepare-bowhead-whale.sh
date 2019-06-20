#!/bin/bash

echo ">>> downloading"

wget http://alfred.liv.ac.uk/downloads/bowhead_whale/bowhead_whale_coding_sequences.zip
wget http://alfred.liv.ac.uk/downloads/bowhead_whale/bowhead_whale_proteins.zip
wget http://alfred.liv.ac.uk/downloads/bowhead_whale/bowhead_whale_scaffolds.zip
wget http://alfred.liv.ac.uk/downloads/bowhead_whale/Bickham_Trinity.zip
wget http://alfred.liv.ac.uk/downloads/bowhead_whale/Bo_bowhead_MusKid_TrinityFasta.zip

echo ">>> converting from zip to gzip"

unzip bowhead_whale_coding_sequences.zip
gzip bowhead_whale_coding_sequences.fasta
rm bowhead_whale_coding_sequences.zip
rm readme.txt

unzip bowhead_whale_proteins.zip
gzip bowhead_whale_proteins.fasta
rm bowhead_whale_proteins.zip
rm readme.txt

unzip bowhead_whale_scaffolds.zip
mv scaffolds.fasta bowhead_whale_scaffolds.fasta
gzip bowhead_whale_scaffolds.fasta
rm bowhead_whale_scaffolds.zip
rm readme.txt

unzip Bickham_Trinity.zip
mv Trinity.fasta Bickham_Trinity.fasta
gzip Bickham_Trinity.fasta
rm Bickham_Trinity.zip
rm readme.txt

unzip Bo_bowhead_MusKid_TrinityFasta.zip
mv Trinity.fasta Bo_bowhead_MusKid_TrinityFasta.fasta
gzip Bo_bowhead_MusKid_TrinityFasta.fasta
rm Bo_bowhead_MusKid_TrinityFasta.zip
rm readme.txt

echo ">>> moving to HDFS"

hadoop fs -put bowhead_whale_coding_sequences.fasta.gz bowhead_whale_coding_sequences.fasta.gz
hadoop fs -put bowhead_whale_proteins.fasta.gz bowhead_whale_proteins.fasta.gz
hadoop fs -put bowhead_whale_scaffolds.fasta.gz bowhead_whale_scaffolds.fasta.gz
hadoop fs -put Bickham_Trinity.fasta.gz Bickham_Trinity.fasta.gz
hadoop fs -put Bo_bowhead_MusKid_TrinityFasta.fasta.gz Bo_bowhead_MusKid_TrinityFasta.fasta.gz

echo ">>> done"
