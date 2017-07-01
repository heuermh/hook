#!/bin/bash

echo "installing local version of Apache Maven version 3.3.9..."
wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xvfz apache-maven-3.3.9-bin.tar.gz
rm apache-maven-3.3.9-bin.tar.gz

echo "To add mvn to your path:"
echo "export PATH=`pwd`/apache-maven-3.3.9/bin:$PATH"
