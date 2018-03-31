#!/bin/bash

echo "building and installing Cannoli latest dev version from git HEAD..."
git clone https://github.com/bigdatagenomics/cannoli.git
cd cannoli/
mvn package -DskipTests=true
cd ..

echo "To add cannoli to your path:"
echo "export PATH=`pwd`/cannoli/bin:\$PATH"
