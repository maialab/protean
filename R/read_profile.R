#' Read a sequence profile
#'
#' @param file A path to a sequence profile file.
#'
#' @return A [tibble][tibble::tibble-package] of 10 variables:
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
#' @md
#' @examples
#' read_profile(profile_path("TP53"))
#' @export
read_profile <- function(file = stop('`file` must be specified')) {

  tibble::as_tibble(utils::read.csv(file = file))

}
