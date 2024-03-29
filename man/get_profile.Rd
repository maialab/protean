% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_profile.R
\name{get_profile}
\alias{get_profile}
\title{Get sequence profiles}
\usage{
get_profile(symbol, simplify = TRUE)
}
\arguments{
\item{symbol}{A character vector of HUGO gene symbols.}

\item{simplify}{Should the result be simplified if only one gene symbol is
queried. If \code{TRUE}, then in the case only one gene symbol is queried the
result is not a list of one tibble, but the tibble itself.}
}
\value{
A list of \link[tibble:tibble-package]{tibbles}, one for each gene symbol
queried, with the following columns:
\describe{
\item{\code{timestamp}}{Date and time of the download from Ensembl.}
\item{\code{human_prot_id}}{Ensembl identifier of the human protein sequence.}
\item{\code{ortho_prot_id}}{Ensembl identifier of the ortholog protein sequence.}
\item{\code{ortho_species}}{Species name of the ortholog sequence.}
\item{\code{human_align_seq}}{In the context of pairwise alignment between the
human sequence and one of its orthologs, this is the aligned human sequence.}
\item{\code{ortho_align_seq}}{In the context of pairwise alignment between the
human sequence and one of its orthologs, this is the aligned ortholog
sequence.}
\item{\code{human_ortho_perc_id}}{Percentage of the human sequence matching the
sequence of the ortholog.}
\item{\code{ortho_human_perc_id}}{Percentage of the orthologous sequence matching
the human sequence.}
\item{\code{human_profile_id}}{Human protein sequence.}
\item{\code{ortho_profile_seq}}{Orthologous sequence stripped off of the alignment
positions which correspond to gaps in the human sequence.}
}
}
\description{
This function retrieves pairwise alignments between the human sequence
queried in \code{symbol} and each of its orthologs via Ensembl's REST API
\verb{homology/symbol/:species/:symbol} endpoint. Then, from these alignments,
sequence profiles are derived.
}
