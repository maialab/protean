#' @importFrom rlang .data
get_alignments_ <- function(symbol) {

  resource <- glue::glue("/homology/symbol/human/{symbol}")
  resp <- get(resource = resource, type = "orthologues", sequence = "protein")

  if (httr2::resp_status(resp) != 200L) {
    tbl2 <- tibble::tibble(
      timestamp = as.POSIXct(vector()),
      human_prot_id = character(),
      ortho_prot_id = character(),
      ortho_species = character(),
      human_align_seq = character(),
      ortho_align_seq = character(),
      human_ortho_perc_id = character(),
      ortho_human_perc_id = character()
    )
  } else {

  json <- httr2::resp_body_string(resp, encoding = "UTF-8")

  tbl <-
    json %>%
    tidyjson::enter_object("data") %>%
    tidyjson::gather_array() %>%
    dplyr::select(-"array.index") %>%
    tidyjson::enter_object("homologies") %>%
    tidyjson::gather_array()

  if (identical(nrow(tbl), 0L)) {
    tbl2 <- tibble::tibble(
      timestamp = as.POSIXct(vector()),
      human_prot_id = character(),
      ortho_prot_id = character(),
      ortho_species = character(),
      human_align_seq = character(),
      ortho_align_seq = character(),
      human_ortho_perc_id = character(),
      ortho_human_perc_id = character(),
      cigar = character()
    )
  } else {
    tbl2 <-
      tbl %>%
      tidyjson::spread_all() %>%
      tidyjson::as_tibble() %>%
      dplyr::transmute(
        timestamp = Sys.time(),
        human_prot_id = .data$source.protein_id,
        ortho_prot_id = .data$target.protein_id,
        ortho_species = .data$target.species,
        human_align_seq = .data$source.align_seq,
        ortho_align_seq = .data$target.align_seq,
        human_ortho_perc_id = .data$source.perc_id,
        ortho_human_perc_id = .data$target.perc_id,
        cigar = .data$target.cigar_line
      )
  }
  }

  return(tbl2)
}

get_alignments <- function(symbol) {

  lst <- lapply(symbol, get_alignments_)
  lst <- stats::setNames(lst, nm = symbol)

  lst

}
