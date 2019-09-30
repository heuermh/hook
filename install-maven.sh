#!/bin/bash

echo "installing local version of Apache Maven version 3.6.2..."
wget http://apache.osuosl.org/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
tar xvfz apache-maven-3.6.2-bin.tar.gz
rm apache-maven-3.6.2-bin.tar.gz

echo "To add mvn to your path:"
echo "export PATH=`pwd`/apache-maven-3.6.2/bin:\$PATH"
