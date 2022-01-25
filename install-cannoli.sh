#!/bin/bash

VERSION=0.15.0

echo "installing Cannoli release version $VERSION..."
wget https://repo1.maven.org/maven2/org/bdgenomics/cannoli/cannoli-distribution-spark3_2.12/$VERSION/cannoli-distribution-spark3_2.12-$VERSION-bin.tar.gz
tar xvfz cannoli-distribution-spark3_2.12-$VERSION-bin.tar.gz
rm cannoli-distribution-spark3_2.12-$VERSION-bin.tar.gz

echo "To add cannoli to your path:"
echo "export PATH=`pwd`/cannoli-distribution-spark3_2.12-$VERSION/bin:\$PATH"
