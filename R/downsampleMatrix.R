#' Downsample a count matrix
#'
#' Downsample a count matrix to a desired proportion, either on a whole-matrix or per-cell basis.
#' 
#' @param x An integer or numeric matrix-like object containing counts.
#' @param prop A numeric scalar or, if \code{bycol=TRUE}, a vector of length \code{ncol(x)}.
#' All values should lie in [0, 1] specifying the downsampling proportion for the matrix or for each cell.
#' @param bycol A logical scalar indicating whether downsampling should be performed on a column-by-column basis.
#' 
#' @return An integer or numeric matrix-like object of downsampled counts, usually of the same class as \code{x}.
#' 
#' @details
#' Given multiple batches of very different sequencing depths, 
#' it can be beneficial to downsample the deepest batches to match the coverage of the shallowest batches. 
#' This avoids differences in technical noise that can drive clustering by batch.
#' 
#' If \code{bycol=TRUE}, sampling without replacement is performed on the count vector for each cell.
#' This yields a new count vector where the total is equal to \code{prop} times the original total count. 
#' Each count in the returned matrix is guaranteed to be smaller than the original value in \code{x}.
#' Different proportions can be specified for different cells by setting \code{prop} to a vector;
#' in this manner, downsampling can be used as an alternative to scaling for per-cell normalization.
#' 
#' If \code{bycol=FALSE}, downsampling without replacement is performed on the entire matrix.
#' This yields a new matrix where the total count across all cells is equal to \code{prop} times the original total.
#' The new total count for each cell may not be exactly equal to \code{prop} times the original value,
#' which may or may not be more appropriate than \code{bycol=TRUE} for particular applications.
#' 
#' Note that this function was originally implemented in the \pkg{scater} package as \code{downsampleCounts},
#' was moved to the \pkg{DropletUtils} package as \code{downsampleMatrix},
#' and finally found a home here.
#' 
#' @author
#' Aaron Lun
#' 
#' @seealso
#' \code{\link[DropletUtils]{downsampleReads}} in the \pkg{DropletUtils} package, 
#' which downsamples reads rather than observed counts.
#'
#' \code{\link{normalizeCounts}}, where downsampling can be used as an alternative to scaling normalization.
#' 
#' @examples
#' sce <- mockSCE()
#' sum(counts(sce))
#' 
#' downsampled <- downsampleMatrix(counts(sce), prop = 0.5, bycol=FALSE)
#' sum(downsampled)
#' @export
downsampleMatrix <- function(x, prop, bycol=TRUE) {
    if (bycol) {
        prop <- rep(prop, length.out = ncol(x))
        out <- downsample_column(x, prop)
    } else {
        out <- downsample_matrix(x, sum(x), prop)
    }

    dimnames(out) <- dimnames(x)
    out
}