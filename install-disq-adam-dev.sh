#!/bin/bash

echo "building and installing disq-adam latest dev version from git HEAD..."
git clone https://github.com/heuermh/disq-adam.git
cd disq-adam/
mvn package -DskipTests=true
cd ..

DISQ_ADAM_JAR=$(ls -1 "target" | grep "^disq[0-9A-Za-z\.\_\-]*\.jar$" | grep -v javadoc | grep -v sources || true)
echo "To use disq-adam:"
echo "  adam-submit --packages $DISQ_ADAM_JAR ..."
