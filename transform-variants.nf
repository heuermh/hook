#!/usr/bin/env nextflow

params.srcDir = "${baseDir}/example" // "s3://read-bucket/dir"
params.destDir = "${baseDir}/example" // "s3://write-bucket/dir"
params.driverMemory = "58G"
params.executorMemory = "58G"
params.hdfsDir = "/data"
params.hdfsPath = "hdfs://spark-master:8020${params.hdfsDir}"
params.conductorJar = "conductor-0.5-SNAPSHOT/conductor-0.5-SNAPSHOT-distribution.jar"

vcfFiles = "${params.srcDir}/**.vcf.gz"
vcfs = Channel.fromPath(vcfFiles).map { path -> tuple(path.baseName, path) }

process prepare {
  tag { sample }

  input:
    set sample, path from vcfs
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
    ${params.hdfsPath}/${sample}.vcf.gz \
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
    --driver-memory ${params.driverMemory} \
    --executor-memory ${params.executorMemory} \
    -- \
    transformVariants \
    ${params.hdfsPath}/${sample}.vcf.gz \
    ${params.hdfsPath}/${sample}.variants.adam
  """
}

process upload {
  tag { sample }

  input:
    set sample, path from transformed
  output:
    set sample, path into uploaded

  """
  spark-submit \
    ${params.conductorJar} \
    ${params.hdfsPath}/${sample}.variants.adam \
    ${params.destDir}/${sample}.variants.adam
  """
}

process report {
  tag { sample }

  input:
    set sample, path from uploaded

  """
  echo "Transformed ${sample} variants from ${path} and uploaded to ${params.destDir}."
  """
}
