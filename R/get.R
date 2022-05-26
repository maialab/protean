get_ <- function(resource, ...) {
  params <- list(
    ...
  )

  base_url <- 'https://rest.ensembl.org/'

  httr2::request(base_url) %>%
    httr2::req_url_path_append(resource) %>%
    httr2::req_url_query(!!!params) %>%
    httr2::req_headers(Accept = 'application/json') %>%
    httr2::req_user_agent("R package protean (https://maialab.org/protean)") %>%
    httr2::req_error(is_error = ~ FALSE) %>%
    httr2::req_perform()
}

get <- memoise::memoise(get_)

