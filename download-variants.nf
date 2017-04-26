#!/usr/bin/env nextflow

params.srcDir = "${baseDir}/example" // "s3://read-bucket/dir"
params.hdfsDir = "/data"
params.hdfsPath = "hdfs://spark-master:8020${params.hdfsDir}"
params.conductorJar = "conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar"

variantFiles = "${params.srcDir}/**.variants.adam"
variants = Channel.fromPath(variantFiles).map { path -> tuple(path.baseName, path) }

process prepare {
  tag { sample }

  input:
    set sample, path from variants
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
    ${params.hdfsPath}/${sample}.variants.adam
  """
}

process report {
  tag { sample }

  input:
    set sample, path from uploaded

  """
  echo "Downloaded ${sample} variants from ${path} to ${params.hdfsPath}."
  """
}
