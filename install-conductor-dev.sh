#!/bin/bash

echo "building and installing conductor latest dev version from git HEAD..."
git clone https://github.com/BD2KGenomics/conductor.git conductor-0.5-SNAPSHOT
cd conductor-0.5-SNAPSHOT
mvn package -DskipTests=true
cp conductor/target/conductor-0.5-SNAPSHOT-distribution.jar .
cd ..
