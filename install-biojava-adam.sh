#!/bin/bash

VERSION=1.0

echo "installing biojava-adam release version $VERSION..."

mkdir biojava-adam
cd biojava-adam
wget https://repo1.maven.org/maven2/org/biojava/biojava-adam/$VERSION/biojava-adam-$VERSION.jar
cd ..
