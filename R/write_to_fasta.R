#' Write sequence profile as FASTA
#'
#' @param seq_profile A sequence profile, i.e. a data frame obtained with either
#'   [get_profile()] or [read_profile()].
#' @param file A path to a file for exporting the sequence profile.
#'
#' @return This function is run for its side effect, i.e. writing the FASTA
#'   file.
#'
#' @md
#' @keywords internal
#' @export
write_to_fasta <-
  function(seq_profile, file = stop('`file` must be specified')) {

    # FASTA headers
    header <-
      c(
        paste("homo_sapiens", seq_profile$human_prot_id[1], sep = "_"),
        paste(seq_profile$ortho_species, seq_profile$ortho_prot_id, sep = "_")
      )

    header <- paste0(">", header)

    # `seq`: a vector of profile sequences starting with the human sequence
    seq <-
      c(
        seq_profile$human_profile_seq[1],
        seq_profile$ortho_profile_seq
      )

    txt <- paste(header, seq, sep = "\n")

    writeLines(text = txt, con = file)

  }
