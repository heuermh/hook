#!/bin/bash

echo "installing Cannoli release version 0.12.0..."
wget https://repo1.maven.org/maven2/org/bdgenomics/cannoli/cannoli-distribution-spark3_2.12/0.12.0/cannoli-distribution-spark3_2.12-0.12.0-bin.tar.gz
tar xvfz cannoli-distribution-spark3_2.12-0.12.0-bin.tar.gz
rm cannoli-distribution-spark3_2.12-0.12.0-bin.tar.gz

echo "To add cannoli to your path:"
echo "export PATH=`pwd`/cannoli-distribution-spark3_2.12-0.12.0/bin:\$PATH"
