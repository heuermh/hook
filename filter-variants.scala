import org.bdgenomics.adam.models._
import org.bdgenomics.adam.ds.ADAMContext._
import org.bdgenomics.adam.util.ADAMShell._

val ml = createMetricsListener(sc)
val mhc = ReferenceRegion.fromGenomicRange("6", 28477796L, 33448354L)
val kir = ReferenceRegion.fromGenomicRange("19", 55228187L, 55383188L)

val before = System.nanoTime()

val variants = sc.loadParquetVariants("sample.variants.adam").filterByOverlappingRegions(Seq(mhc, kir))

variants.dataset.filter("filtersPassed = true").count()

printMetrics(System.nanoTime() - before, ml)
System.exit(0)
