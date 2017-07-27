#!/bin/bash

echo "building and installing ADAM latest dev version from git HEAD..."
git clone https://github.com/bigdatagenomics/adam.git
cd adam/
mvn package -DskipTests=true
cd ..

echo "To add adam to your path:"
echo "export PATH=`pwd`/adam/bin:\$PATH"
