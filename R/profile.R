#' Get the path to a sequence profile
#'
#' protean comes bundled with a number of sequence profile files in its
#' `inst/profiles` directory. This function make them easy to access by
#' returning the local path to them.
#'
#' @param file Name of file or gene symbol. If `NULL`, the profile files will be
#'   listed.
#'
#' @md
#' @examples
#' # Retrieve the path to the sequence profile of the TP53 protein
#' # Using the gene symbol
#' profile_path("TP53")
#'
#' # Using the file name
#' profile_path("TP53.csv.gz")
#'
#' # List all profile files
#' profile_path()
#' @export
profile_path <- function(file = NULL) {
  if (is.null(file)) {
    dir(system.file("profiles", package = "protean"))
  } else {

    if(all(!grepl("\\.csv\\.gz$", file, perl = TRUE)))
      file <- paste0(file, ".csv.gz")

    system.file("profiles", file, package = "protean", mustWork = TRUE)
  }
}
