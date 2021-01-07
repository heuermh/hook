\#!/bin/bash

echo "installing dsh-bio release version 1.4..."
wget https://repo1.maven.org/maven2/org/dishevelled/dsh-bio-tools/1.4/dsh-bio-tools-1.4-bin.tar.gz
tar xvfz dsh-bio-tools-1.4-bin.tar.gz
rm dsh-bio-tools-1.4-bin.tar.gz

echo "To add dsh-bio to your path:"
echo "export PATH=`pwd`/dsh-bio-tools-1.4/bin:\$PATH"