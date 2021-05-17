import org.apache.parquet.filter2.dsl.Dsl._
import org.apache.parquet.filter2.predicate.FilterPredicate

import org.bdgenomics.adam.models._
import org.bdgenomics.adam.ds.ADAMContext._
import org.bdgenomics.adam.util.ADAMShell._

val ml = createMetricsListener(sc)
val mhc = ReferenceRegion.fromGenomicRange("6", 28477796L, 33448354L)
val kir = ReferenceRegion.fromGenomicRange("19", 55228187L, 55383188L)
val mapq: FilterPredicate = (IntColumn("mapq") > 20)

val before = System.nanoTime()

val alignments = sc.loadParquetAlignments("sample.alignments.adam", optPredicate = Some(mapq)).filterByOverlappingRegions(Seq(mhc, kir))

alignments.dataset.count()

printMetrics(System.nanoTime() - before, ml)
System.exit(0)
