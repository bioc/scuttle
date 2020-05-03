#' Aggregate feature sets in a SummarizedExperiment
#' 
#' Sum together expression values (by default, counts) for each feature set 
#' in each cell of a \linkS4class{SummarizedExperiment} object.
#'
#' @param x A \linkS4class{SummarizedExperiment} containing a count matrix.
#' @inheritParams sumCountsAcrossFeatures
#' @param ... Further arguments to be passed to \code{sumCountsAcrossFeatures}.
#' @param use.assay.type A character or integer vector specifying the assay(s) of \code{x} containing count matrices.
#' @param use_exprs_values Soft-deprecated equivalent of \code{use.assay.type}.
#'
#' @return 
#' A SummarizedExperiment of the same class as \code{x} is returned,
#' containing summed matrices generated by \code{sumCountsAcrossFeatures} on all assays in \code{use.assay.type}.
#' Row metadata is retained for the first instance of a feature from each set in \code{ids}.
#'
#' @seealso
#' \code{\link{sumCountsAcrossFeatures}}, which does the heavy lifting.
#'
#' @author Aaron Lun
#'
#' @examples
#' example_sce <- mockSCE()
#' ids <- sample(LETTERS, nrow(example_sce), replace=TRUE)
#' aggr <- aggregateAcrossFeatures(example_sce, ids)
#' aggr
#'
#' @export
#' @importFrom SummarizedExperiment assays<-
aggregateAcrossFeatures <- function(x, ids, ..., use.assay.type="counts") {
    collected <- list()
    for (i in seq_along(use.assay.type)) {
        collected[[i]] <- sumCountsAcrossFeatures(x, ids=ids, ..., exprs_values=use.assay.type[i])
    }
    names(collected) <- .choose_assay_names(x, use.assay.type)

    x <- x[match(rownames(collected[[1]]), as.character(ids)),]
    assays(x, withDimnames=FALSE) <- collected
    rownames(x) <- rownames(collected[[1]])
    x
}

#' @importFrom SummarizedExperiment assayNames
.choose_assay_names <- function(x, use.assay.type) {
    if (is.numeric(use.assay.type)) {
        assayNames(x)[use.assay.type]
    } else {
        use.assay.type
    }
}