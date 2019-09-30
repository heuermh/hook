#!/bin/bash

echo "building and installing biojava-adam latest dev version from git HEAD..."
git clone https://github.com/biojava/biojava-adam.git
cd biojava-adam/
mvn install -DskipTests=true
cd ..
