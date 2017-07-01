#!/bin/bash

# transform-alignments.sh s3://source sample s3://dest
SRC_DIR = $1
SAMPLE = $2
DEST_DIR = $3
DRIVER_MEMORY = "58G"
EXECUTOR_MEMORY = "58G"
HDFS_DIR = "/data"
HDFS_PATH = "hdfs://spark-master:8020$HDFS_DIR"

echo "creating $HDFS_DIR directory on hdfs..."
hadoop fs -mkdir -p "$HDFS_DIR"

echo "downloading $SRC_DIR/$SAMPLE.bam to $HDFS_PATH/$SAMPLE.bam..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $SRC_DIR/$SAMPLE.bam \
    $HDFS_PATH/$SAMPLE.bam \
    --concat

echo "converting $HDFS_PATH/$SAMPLE.bam to $HDFS_PATH/$SAMPLE.alignments.adam..."
adam-submit \
    --driver-memory $DRIVER_MEMORY \
    --executor-memory $EXECUTOR_MEMORY \
    -- \
    transformAlignments \
    $HDFS_PATH/$SAMPLE.bam \
    $HDFS_PATH/$SAMPLE.alignments.adam

echo "uploading $HDFS_PATH/$SAMPLE.alignments.adam to $DEST_DIR..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $HDFS_PATH/$SAMPLE.alignments.adam \
    $DEST_DIR/$SAMPLE.alignments.adam
