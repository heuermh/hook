#!/bin/bash

# transform-genotypes.sh s3://source sample s3://dest
SRC_DIR=$1
SAMPLE=$2
DEST_DIR=$3
DRIVER_MEMORY="58G"
EXECUTOR_MEMORY="58G"
HDFS_DIR="/data"
HDFS_PATH="hdfs://spark-master:8020$HDFS_DIR"

echo "creating $HDFS_DIR directory on hdfs..."
hadoop fs -mkdir -p "$HDFS_DIR"

echo "downloading $SRC_DIR/$SAMPLE.vcf.gz to $HDFS_PATH/$SAMPLE.vcf.gz with conductor..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $SRC_DIR/$SAMPLE.vcf.gz \
    $HDFS_PATH/$SAMPLE.vcf.gz \
    --concat

echo "converting $HDFS_PATH/$SAMPLE.vcf.gz to $HDFS_PATH/$SAMPLE.genotypes.adam..."
adam-submit \
    --driver-memory $DRIVER_MEMORY \
    --executor-memory $EXECUTOR_MEMORY \
    -- \
    transformGenotypes \
    $HDFS_PATH/$SAMPLE.vcf.gz \
    $HDFS_PATH/$SAMPLE.genotypes.adam

echo "uploading $HDFS_PATH/$SAMPLE.genotypes.adam to $DEST_DIR with conductor..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $HDFS_PATH/$SAMPLE.genotypes.adam \
    $DEST_DIR/$SAMPLE.genotypes.adam
