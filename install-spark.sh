#!/bin/bash

VERSION=3.5.3

echo "installing Spark release version $VERSION..."
wget https://downloads.apache.org/spark/spark-$VERSION/spark-$VERSION-bin-hadoop3.tgz -O spark-$VERSION-bin-hadoop3.tgz
tar xvfz spark-$VERSION-bin-hadoop3.tgz
rm spark-$VERSION-bin-hadoop3.tgz

echo "To add Spark to your path:"
echo "export PATH=`pwd`/spark-$VERSION-bin-hadoop3/bin:\$PATH"
echo " "
echo "To set SPARK_HOME appropriately:"
echo "export SPARK_HOME=`pwd`/spark-$VERSION-bin-hadoop3"
