#!/usr/bin/env nextflow

params.srcDir = "${baseDir}/example" // "s3://read-bucket/dir"
params.hdfsDir = "/data"
params.hdfsPath = "hdfs://spark-master:8020${params.hdfsDir}"
params.conductorJar = "conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar"

alignmentFiles = "${params.srcDir}/**.alignments.adam"
alignments = Channel.fromPath(alignmentFiles).map { path -> tuple(path.baseName, path) }

process prepare {
  tag { sample }

  input:
    set sample, path from alignments
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
    ${params.conductorJar} \
    ${path} \
    ${params.hdfsPath}/${sample}.alignments.adam
  """
}

process report {
  tag { sample }

  input:
    set sample, path from uploaded

  """
  echo "Downloaded ${sample} alignments from ${path} to ${params.hdfsPath}."
  """
}
