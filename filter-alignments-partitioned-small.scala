import org.bdgenomics.adam.models._
import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.adam.util.ADAMShell._

val ml = createMetricsListener(sc)
val hlaB = ReferenceRegion.fromGenomicRange("6", 31321648L, 31324965L)
val before = System.nanoTime()

val alignments = sc.loadPartitionedParquetAlignments("sample.alignments.partitioned.adam", Seq(hlaB))

alignments.dataset.filter("filtersPassed = true").count()

printMetrics(System.nanoTime() - before, ml)
System.exit(0)
