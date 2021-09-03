#!/bin/bash

VERSION=0.36.0

echo "installing ADAM release version $VERSION..."
wget https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution-spark3_2.12/$VERSION/adam-distribution-spark3_2.12-$VERSION-bin.tar.gz
tar xvfz adam-distribution-spark3_2.12-$VERSION-bin.tar.gz
rm adam-distribution-spark3_2.12-$VERSION-bin.tar.gz

echo "To add adam to your path:"
echo "export PATH=`pwd`/adam-distribution-spark3_2.12-$VERSION/bin:\$PATH"
