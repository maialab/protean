str_to_chr <- function(str) {
  unlist(strsplit(str, ""))
}

which_gaps <- function(str) {
  which(str_to_chr(str) == '-')
}

pairwise_profile_ <- function(human_align_seq, ortho_align_seq) {

  # Human gap positions
  human_gap_pos <- which_gaps(human_align_seq)

  if (identical(length(human_gap_pos), 0L)) {
    return(c(
      human_profile_seq = human_align_seq,
      ortho_profile_seq = ortho_align_seq
    ))
  }

  human_profile_seq <- paste0(str_to_chr(human_align_seq)[-human_gap_pos], collapse = "")
  ortho_profile_seq <- paste0(str_to_chr(ortho_align_seq)[-human_gap_pos], collapse = "")

  c(human_profile_seq = human_profile_seq, ortho_profile_seq = ortho_profile_seq)

}

pairwise_profile <- function(human_align_seq, ortho_align_seq) {

  purrr::map2_dfr(human_align_seq, ortho_align_seq, pairwise_profile_)
}

add_profile_seq_ <- function(alignments) {

  profiles <- pairwise_profile(
    human_align_seq = alignments$human_align_seq,
    ortho_align_seq = alignments$ortho_align_seq
  )

  dplyr::bind_cols(alignments, profiles)

}

add_profile_seq <- function(alignments) {

  purrr::map(alignments, add_profile_seq_)

}

create_profile_ <- function(alignments) {

  n_orthologs <- nrow(alignments)
  n_profile_seqs <- n_orthologs + 1 # `+1` because of the human sequence

  profile_seqs <- c(alignments$human_profile_seq[1], alignments$ortho_profile_seq)

  m <- matrix(str_to_chr(profile_seqs), nrow = n_profile_seqs, byrow = TRUE)

  row_names <-
    c(
      paste("homo_sapiens", alignments$human_prot_id[1], sep = "_"),
      paste(alignments$ortho_species, alignments$ortho_prot_id, sep = "_")
    )

  rownames(m) <- row_names

  m

}

create_profile <- function(alignments) {

  purrr::map(alignments, create_profile_)

}

#' Get sequence profiles
#'
#' This function retrieves pairwise alignments between the human sequence
#' queried in `symbol` and each of its orthologs via Ensembl's REST API
#' `homology/symbol/:species/:symbol` endpoint. Then, from these alignments,
#' sequence profiles are derived.
#'
#' @param symbol A character vector of HUGO gene symbols.
#' @param simplify Should the result be simplified if only one gene symbol is
#'   queried. If `TRUE`, then in the case only one gene symbol is queried the
#'   result is not a list of one tibble, but the tibble itself.
#'
#' @return A list of [tibbles][tibble::tibble-package], one for each gene symbol
#'   queried, with the following columns:
#' \describe{
#' \item{`timestamp`}{Date and time of the download from Ensembl.}
#' \item{`human_prot_id`}{Ensembl identifier of the human protein sequence.}
#' \item{`ortho_prot_id`}{Ensembl identifier of the ortholog protein sequence.}
#' \item{`ortho_species`}{Species name of the ortholog sequence.}
#' \item{`human_align_seq`}{In the context of pairwise alignment between the
#' human sequence and one of its orthologs, this is the aligned human sequence.}
#' \item{`ortho_align_seq`}{In the context of pairwise alignment between the
#' human sequence and one of its orthologs, this is the aligned ortholog
#' sequence.}
#' \item{`human_ortho_perc_id`}{Percentage of the human sequence matching the
#' sequence of the ortholog.}
#' \item{`ortho_human_perc_id`}{Percentage of the orthologous sequence matching
#' the human sequence.}
#' \item{`human_profile_id`}{Human protein sequence.}
#' \item{`ortho_profile_seq`}{Orthologous sequence stripped off of the alignment
#' positions which correspond to gaps in the human sequence.}
#' }
#'
#'
#' @md
#' @export
get_profile <- function(symbol, simplify = TRUE) {

  alignments <- get_alignments(symbol)
  profiles <- add_profile_seq(alignments)

  if(identical(length(symbol), 1L) && simplify) return(profiles[[1]])

  profiles
}
