#!/usr/bin/env nextflow

params.srcDir = "${baseDir}/example" // "s3://read-bucket/dir"
params.destDir = "${baseDir}/example" // "s3://write-bucket/dir"
params.hdfsDir = "/data"
params.hdfsPath = "hdfs://spark-master:8020${params.hdfsDir}"
params.conductorJar = "conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar"

//
// EMR cluster with:
// 1x 16 vCPUs 30G RAM master node (m3.2xlarge)
// 8x 16 vCPUs 61G RAM worker nodes (r3.2xlarge)
params.sparkMaster = "yarn"
params.deployMode = "cluster"
params.driverCores = "14"
params.driverMemory = "22G"
params.executorCores = "14"
params.executorMemory = "50G"


bamFiles = "${params.srcDir}/**.bam"
bams = Channel.fromPath(bamFiles).map { path -> tuple(path.baseName, path) }

process prepare {
  tag { sample }

  input:
    set sample, path from bams
  output:
    set sample, path into prepared

  """
  hadoop fs -mkdir -p ${params.hdfsDir}
  """
}

process download {
  tag { sample }

  input:
    set sample, path from prepared
  output:
    set sample, path into downloaded

  """
  spark-submit \
    --master ${params.sparkMaster} \
    --deploy-mode ${params.deployMode} \
    ${params.conductorJar} \
    ${path} \
    ${params.hdfsPath}/${sample}.bam \
    --concat
  """
}

process transform {
  tag { sample }

  input:
    set sample, path from downloaded
  output:
    set sample, path into transformed

  """
  adam-submit \
    --master ${params.sparkMaster} \
    --deploy-mode ${params.deployMode} \
    --driver-memory ${params.driverMemory} \
    --executor-memory ${params.executorMemory} \
    --conf spark.driver.cores=${params.driverCores} \
    --conf spark.executor.cores=${params.executorCores} \
    --conf spark.yarn.executor.memoryOverhead=2048 \
    -- \
    transformAlignments \
    ${params.hdfsPath}/${sample}.bam \
    ${params.hdfsPath}/${sample}.alignments.adam
  """
}

process upload {
  tag { sample }

  input:
    set sample, path from transformed
  output:
    set sample, path into uploaded

  """
  s3-dist-cp \
    --src ${params.hdfsPath}/${sample}.alignments.adam \
    --dest ${params.destDir}/${sample}.alignments.adam
  """
}

process report {
  tag { sample }

  input:
    set sample, path from uploaded

  """
  echo "Transformed ${sample} alignments from ${path} and uploaded to ${params.destDir}."
  """
}
