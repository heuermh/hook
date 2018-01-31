#!/bin/bash

# transform-alignments.sh s3://source sample s3://dest
SRC_DIR=$1
SAMPLE=$2
DEST_DIR=$3
HDFS_DIR="/data"
HDFS_PATH="hdfs://spark-master:8020$HDFS_DIR"

#
# EMR cluster with:
# 1x 16 vCPUs 30G RAM master node (m3.2xlarge)
# 8x 16 vCPUs 61G RAM worker nodes (r3.2xlarge)
DRIVER_MEMORY="22G"
DRIVER_CORES="14"
EXECUTOR_MEMORY="50G"
EXECUTOR_CORES="14"

echo "creating $HDFS_DIR directory on hdfs..."
hadoop fs -mkdir -p "$HDFS_DIR"

echo "downloading $SRC_DIR/$SAMPLE.bam to $HDFS_PATH/$SAMPLE.bam with conductor..."
spark-submit \
    conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar \
    $SRC_DIR/$SAMPLE.bam \
    $HDFS_PATH/$SAMPLE.bam \
    --concat

echo "converting $HDFS_PATH/$SAMPLE.bam to $HDFS_PATH/$SAMPLE.alignments.adam..."
adam-submit \
    --master yarn \
    --deploy-mode cluster \
    --driver-memory $DRIVER_MEMORY \
    --executor-memory $EXECUTOR_MEMORY \
    --conf spark.driver.cores=$DRIVER_CORES \
    --conf spark.executor.cores=$EXECUTOR_CORES \
    --conf spark.yarn.executor.memoryOverhead=2048 \
    -- \
    transformAlignments \
    $HDFS_PATH/$SAMPLE.bam \
    $HDFS_PATH/$SAMPLE.alignments.adam

echo "uploading $HDFS_PATH/$SAMPLE.alignments.adam to $DEST_DIR with s3-dist-cp..."
s3-dist-cp \
    --src $HDFS_PATH/$SAMPLE.alignments.adam \
    --dest $DEST_DIR/$SAMPLE.alignments.adam
