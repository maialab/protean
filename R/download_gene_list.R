#' Download OncoKB Cancer Gene List
#'
#' @param path A character string with the file path where the downloaded file
#'   is to be saved. Tilde-expansion is performed.
#' @param url The URL of the resource providing the OncoKB cancer gene list.
#'
#' @export
download_gene_list <- function(path = stop("`path` must be specified"), url = oncokb_dwl_url()) {
  utils::download.file(url = url, destfile = path)
}
