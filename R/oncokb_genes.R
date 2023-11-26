#' Fetch current OncoKB genes
#'
#' [fetch_oncokb_genes()] retrieves the current set of OncoKB genes from an OncoKB's
#' cancer gene list file.
#'
#' @param file A URL or a file path to the source providing the cancer gene list
#'   file. By default it will automatically download cancerGeneList.tsv from
#'   OncoKB website.
#'
#' @return A character vector of gene names.
#'
#' @examples
#' fetch_oncokb_genes()
#' @export
fetch_oncokb_genes <- function(file = oncokb_dwl_url()) {
  readr::read_tsv(file = file, col_names = FALSE, skip = 1L, show_col_types = FALSE) |>
    dplyr::pull(1L) # First column is the gene name
}
