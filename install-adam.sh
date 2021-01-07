#!/bin/bash

echo "installing ADAM release version 0.33.0..."
wget https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution-spark3_2.12/0.33.0/adam-distribution-spark3_2.12-0.33.0-bin.tar.gz
tar xvfz adam-distribution-spark3_2.12-0.33.0-bin.tar.gz
rm adam-distribution-spark3_2.12-0.33.0-bin.tar.gz

echo "To add adam to your path:"
echo "export PATH=`pwd`/adam-distribution-spark3_2.11-0.33.0/bin:\$PATH"
