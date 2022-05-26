#' Get and save a sequence profile to a file
#'
#' This function fetches a sequence profile via Ensembl's REST API and saves it
#' to a file.
#'
#' @param symbol A gene symbol to be used as query.
#' @param file A path to a file for exporting the sequence profile.
#' @param overwrite Whether to overwrite the file if it already exists.
#' @param warning Whether to print a warning if, for some reason, the sequence
#'   profile for the queried gene symbol was not retrievable.
#'
#' @return This function is run for its side effect, i.e. writing the FASTA
#'   file.
#'
#' @md
#' @keywords internal
#' @export
write_profile <-
  function(symbol,
           file = stop('`file` must be specified'),
           overwrite = FALSE,
           warning = TRUE) {

    if (file.exists(file) &&
        isFALSE(overwrite))
      return(invisible(FALSE))

    profile <- get_profile(symbol)

    if (!identical(nrow(profile), 0L)) {
      utils::write.csv(profile, file = gzfile(file), row.names = FALSE)
      return(invisible(TRUE))
    } else {
      if (warning)
        warning(glue::glue("Could not get a profile for {symbol}!"), call. = FALSE)
      return(invisible(FALSE))
    }
  }
