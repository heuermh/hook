#!/bin/bash

echo "building and installing dsh-bio latest dev version from git HEAD..."
git clone https://github.com/heuermh/dishevelled-bio.git
cd dishevelled-bio/
mvn install -DskipTests=true
cd ..

echo "To add adam to your path:"
echo "export PATH=`pwd`/dishevelled-bio/tools/target/appassembler/bin:\$PATH"
