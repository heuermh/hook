#!/bin/bash

VERSION=2.3

echo "installing dsh-bio release version $VERSION..."
wget https://repo1.maven.org/maven2/org/dishevelled/dsh-bio-tools/$VERSION/dsh-bio-tools-$VERSION-bin.tar.gz
tar xvfz dsh-bio-tools-$VERSION-bin.tar.gz
rm dsh-bio-tools-$VERSION-bin.tar.gz

echo "To add dsh-bio to your path:"
echo "export PATH=`pwd`/dsh-bio-tools-$VERSION/bin:\$PATH"
