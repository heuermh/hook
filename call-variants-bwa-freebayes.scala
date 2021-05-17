import org.bdgenomics.adam.ds.ADAMContext._
import org.bdgenomics.cannoli.Cannoli._
import org.bdgenomics.cannoli.{ BwaMemArgs, FreebayesArgs }

val sample = "sample"
val reference = "ref.fa"
val addFiles = false

val reads = sc.loadPairedFastqAsFragments(sample + "_1.fq", sample + "_2.fq")
//val reads = sc.loadInterleavedFastqAsFragments(sample + ".ifq")

val bwaArgs = new BwaMemArgs()
bwaArgs.sample = sample
bwaArgs.indexPath = reference
bwaArgs.addFiles = addFiles
bwaArgs.useDocker = true

val alignments = reads.alignWithBwaMem(bwaArgs)
val sorted = alignments.sortReadsByReferencePositionAndIndex()
val markdup = sorted.markDuplicates()

markdup.saveAsParquet(sample + ".alignments.adam")

val freebayesArgs = new FreebayesArgs()
freebayesArgs.referencePath = reference
freebayesArgs.addFiles = addFiles
freebayesArgs.useDocker = true

val variantContexts = markdup.callVariantsWithFreebayes(freebayesArgs)

variantContexts.saveAsParquet(sample + ".variantContexts.adam")
//variantContexts.toVariants().saveAsParquet(sample + ".variants.adam")
//variantContexts.toGenotypes().saveAsParquet(sample + ".genotypes.adam")
