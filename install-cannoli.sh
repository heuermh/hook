#!/bin/bash

echo "installing Cannoli release version 0.6.0..."
wget https://repo1.maven.org/maven2/org/bdgenomics/cannoli/cannoli-distribution-spark2_2.11/0.5.0/cannoli-distribution-spark2_2.11-0.6.0-bin.tar.gz
tar xvfz cannoli-distribution-spark2_2.11-0.6.0-bin.tar.gz
rm cannoli-distribution-spark2_2.11-0.6.0-bin.tar.gz

echo "To add cannoli to your path:"
echo "export PATH=`pwd`/cannoli-distribution-spark2_2.11-0.6.0/bin:\$PATH"
