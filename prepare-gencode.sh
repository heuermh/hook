#!/bin/bash

set -x

# See https://www.gencodegenes.org/human/release_31.html

echo ">>> downloading"

wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.annotation.gff3.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.chr_patch_hapl_scaff.annotation.gff3.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.primary_assembly.annotation.gff3.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.transcripts.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/gencode.v31.pc_translations.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh38.p12.genome.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_31/GRCh38.primary_assembly.genome.fa.gz


echo ">>> generating sequence dictionaries"

dsh-bio create-sequence-dictionary -i GRCh38.p12.genome.fa.gz -o GRCh38.p12.genome.fa.dict
dsh-bio create-sequence-dictionary -i GRCh38.primary_assembly.genome.fa.gz -o GRCh38.primary_assembly.genome.fa.dict


echo ">>> moving to HDFS"

hadoop fs -put gencode.v31.annotation.gff3.gz gencode.v31.annotation.gff3.gz
hadoop fs -put gencode.v31.chr_patch_hapl_scaff.annotation.gff3.gz gencode.v31.chr_patch_hapl_scaff.annotation.gff3.gz
hadoop fs -put gencode.v31.primary_assembly.annotation.gff3.gz gencode.v31.primary_assembly.annotation.gff3.gz
hadoop fs -put gencode.v31.transcripts.fa.gz gencode.v31.transcripts.fa.gz
hadoop fs -put gencode.v31.pc_translations.fa.gz gencode.v31.pc_translations.fa.gz
hadoop fs -put GRCh38.p12.genome.fa.gz GRCh38.p12.genome.fa.gz
hadoop fs -put GRCh38.p12.genome.fa.dict GRCh38.p12.genome.fa.dict
hadoop fs -put GRCh38.primary_assembly.genome.fa.gz GRCh38.primary_assembly.genome.fa.gz
hadoop fs -put GRCh38.primary_assembly.genome.fa.dict GRCh38.primary_assembly.genome.fa.dict

echo ">>> done"
