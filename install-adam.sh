#!/bin/bash

echo "installing ADAM release version 0.22.0..."
wget https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution_2.10/0.22.0/adam-distribution_2.10-0.22.0-bin.tar.gz
tar xvfz adam-distribution_2.10-0.22.0-bin.tar.gz
rm adam-distribution_2.10-0.22.0-bin.tar.gz
export PATH=`pwd`/adam-distribution_2.10-0.22.0/bin:$PATH
