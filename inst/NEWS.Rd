\name{NEWS}
\title{News for Package \pkg{scuttle}}

\section{Version 1.16}{\itemize{
\item \code{addPerCellQCMetrics()} will (optionally) add the feature subset identities to the row data of the SingleCellExperiment.
}}

\section{Version 1.10}{\itemize{
\item \code{.subset2index} now converts factor inputs to character vectors, rather than treating them as integers.
}}

\section{Version 1.8.0}{\itemize{
\item Removed support for \code{use.altexps=} in \code{aggregateAcrossCells()} and \code{logNormCounts()}.

\item Added \code{swap.rownames=} option to \code{makePerCellDF()} to allow easy access by \code{rowData} aliases.
Also moved the extracted features to the end of the data frame for consistency.
}}

\section{Version 1.2.0}{\itemize{
\item Migrated \code{whichNonZero()} to \pkg{beachmat}.

\item Bugfixes for factor-based \code{colData} aggregation in \code{aggregateAcrossCells()}.
Added proper support for Vectors.

\item Bugfix for correct response to \code{use.altexps=} in \code{perCellQCMetrics()}, \code{perFeatureQCMetrics()}.

\item Added a \code{normalize.all=} option to \code{normalizeCounts()}.
Removed unnecessary warning when \code{down.target=} is not specified.
Exposed the default \code{size.factors=} in the SingleCellExperiment method.

\item Modified the SingleCellExperiment method of \code{logNormCounts()} so that manually specified size factors do not apply to alternative Experiments.
Only relevant if \code{size.factors=} and \code{use.altexps=} are specified.

\item Deprecated \code{use.altexps=} in favor of \code{applySCE()} in \code{logNormCounts()} and \code{aggregateAcrossCells()}.

\item Renamed \code{addPerCellQC()} and \code{addPerFeatureQC()} to \code{addPerCellQCMetrics()} and \code{addPerCellFeatureMetrics()}, for consistency.
Soft-deprecated the old functions.

\item Moved most of \code{quickPerCellQC()} functionality into the new \code{perCellQCFilters()} function.
Repurposed the former to directly return a filtered SummarizedExperiment object.

\item Migrated \pkg{scran}'s normalization-related functions into this package.
Added \code{pooledSizeFactors()}, \code{computePooledFactors()}, \code{cleanSizeFactors()} and \code{computeSpikeFactors()}.

\item Added \code{transform="asinh"} to \code{normalizeCounts()} and \code{logNormCounts()} for inverse hyperbolic transformations of CITE-seq data.

\item Modified \code{isOutlier()} to now return \code{outlier.filter} objects.
These are simply logical vectors that preseve the \code{"thresholds"} attribute upon subsetting.

\item Migrated \code{correctGroupSummary()} from \pkg{scater}, to compute corrected versions of group-level summary statistics.
}}

\section{Version 1.0.0}{\itemize{
\item Split off \pkg{scuttle} from \pkg{scater} by migrating all non-visualization code from the latter.

\item Began transition to dot-separate argument names from original snake case format.

\item Added a \code{geometricSizeFactors()} function, deprecated \code{geometric=TRUE} in \code{librarySizeFactors()}.

\item Single-object downsampling in \code{downsampleBatches()} now behaves more consistently with multi-object downsampling.
}}

