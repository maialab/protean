library(here)

cancer_gene_list_path <- here::here('data-raw/cancerGeneList.tsv')
installation_path <- here::here('inst/profiles')
oncokb_genes <- read.table(file = cancer_gene_list_path, sep = "\t", header = FALSE, skip = 1L)[, 1]
profile_path <- file.path(installation_path, paste0(oncokb_genes, ".csv.gz"))

# Export the profiles as compressed csv files to inst/profiles/
purrr::walk2(oncokb_genes,
             profile_path,
             .f = ~ write_profile(.x, file = .y, overwrite = FALSE))

exported_genes <- gsub(pattern = ".csv.gz", replacement = "", list.files(path = installation_path))
missing_genes <- setdiff(oncokb_genes, exported_genes)

usethis::use_data(oncokb_genes, compress = "xz", overwrite = TRUE, version = 2)
usethis::use_data(exported_genes, compress = "xz", overwrite = TRUE, version = 2)
usethis::use_data(missing_genes, compress = "xz", overwrite = TRUE, version = 2)
