#!/bin/bash

VERSION=3.2.0

echo "installing Spark release version $VERSION..."
wget https://downloads.apache.org/spark/spark-$VERSION/spark-$VERSION-bin-hadoop3.2.tgz -O spark-$VERSION-bin-hadoop3.2.tgz
tar xvfz spark-$VERSION-bin-hadoop3.2.tgz
rm spark-$VERSION-bin-hadoop3.2.tgz

echo "To add Spark to your path:"
echo "export PATH=`pwd`/spark-$VERSION-bin-hadoop3.2/bin:\$PATH"
