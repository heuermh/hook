#!/bin/bash

VERSION=3.8.1

echo "installing local version of Apache Maven version $VERSION..."
wget http://apache.osuosl.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz
tar xvfz apache-maven-$VERSION-bin.tar.gz
rm apache-maven-$VERSION-bin.tar.gz

echo "To add mvn to your path:"
echo "export PATH=`pwd`/apache-maven-$VERSION/bin:\$PATH"
