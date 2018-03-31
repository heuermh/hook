import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.cannoli.cli._

val sample = "sample"
val reference = "ref.fa"
val addFiles = false

val reads = sc.loadPairedFastqAsFragments(sample + "_1.fq", sample + "_2.fq")
//val reads = sc.loadInterleavedFastqAsFragments(sample + ".ifq")

val bwaArgs = new BwaFnArgs()
bwaArgs.sample = sample
bwaArgs.indexPath = reference
bwaArgs.addFiles = addFiles
bwaArgs.useDocker = true

val alignments = new BwaFn(bwaArgs, sc).apply(reads)
val sorted = alignments.sortReadsByReferencePositionAndIndex()
val markdup = sorted.markDuplicates()

markdup.saveAsParquet(sample + ".alignments.adam")

val freebayesArgs = new FreebayesFnArgs()
freebayesArgs.referencePath = reference
freebayesArgs.addFiles = addFiles
freebayesArgs.useDocker = true

val variantContexts = new FreebayesFn(freebayesArgs, sc).apply(markdup)

//variantContexts.toVariants().saveAsParquet(sample + ".variants.adam")
variantContexts.toGenotypes().saveAsParquet(sample + ".genotypes.adam")
