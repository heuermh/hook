#!/bin/bash

# download-alignments.sh s3://source sample
SRC_DIR=$1
SAMPLE=$2
HDFS_DIR="/data"
HDFS_PATH="hdfs://spark-master:8020$HDFS_DIR"

echo "creating $HDFS_DIR directory on hdfs..."
hadoop fs -mkdir -p "$HDFS_DIR"

echo "downloading $SRC_DIR/$SAMPLE.alignments.adam to $HDFS_PATH/$SAMPLE.alignments.adam..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $SRC_DIR/$SAMPLE.alignments.adam \
    $HDFS_PATH/$SAMPLE.alignments.adam
