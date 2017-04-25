#!/bin/bash

echo "building and installing ADAM latest dev version from git HEAD..."
git clone https://github.com/bigdatagenomics/adam.git
cd adam/
mvn package -DskipTests=true
cd ..
export PATH=`pwd`/adam/bin:$PATH
