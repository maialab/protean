
<!-- README.md is generated from README.Rmd. Please edit that file -->

# protean <img src="man/figures/logo.svg" align="right" height="139" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/protean)](https://CRAN.R-project.org/package=protean)
<!-- badges: end -->

This package provides protein sequence profiles for OncoKB cancer genes.

These sequence profiles can be useful to infer evolutionary variation at
protein positions which in turn may be used as a proxy for inferring
impact of mutations.

## Installation

``` r
install.packages("protean")
```

You can install the development version of `{protean}` like so:

``` r
# install.packages("remotes")
remotes::install_github("maialab/protean")
```

## Usage

To know the genes whose protein sequence profiles are provided use
`exported_genes`:

``` r
library(protean)

# Number of protein sequence profiles available
length(exported_genes)
#> [1] 1053

# Here's the first 10
exported_genes[1:10]
#>  [1] "ABI1"     "ABL1"     "ABL2"     "ABRAXAS1" "ACKR3"    "ACSL3"   
#>  [7] "ACSL6"    "ACTB"     "ACTG1"    "ACVR1"
```

The protein sequence profiles are bundled with `{protean}` and their
location can be found with `profile_path()`:

``` r
profile_path("TP53")
#> [1] "/home/rmagno/R/x86_64-pc-linux-gnu-library/4.2/protean/profiles/TP53.csv.gz"
```

To import one sequence profile into R use `read_profile()`:

``` r
tp53_prof <- read_profile(profile_path("TP53"))
tp53_prof
#> # A tibble: 254 × 10
#>    timestamp           human_prot_id ortho_prot_id ortho_species human_align_seq
#>    <chr>               <chr>         <chr>         <chr>         <chr>          
#>  1 2022-05-25 23:24:04 ENSP00000269… ENSPPAP00000… pan_paniscus  MEEPQSDPSVEPPL…
#>  2 2022-05-25 23:24:04 ENSP00000269… ENSPTRP00000… pan_troglody… MEEPQSDPSVEPPL…
#>  3 2022-05-25 23:24:04 ENSP00000269… ENSPPYP00000… pongo_abelii  --------------…
#>  4 2022-05-25 23:24:04 ENSP00000269… ENSRROP00000… rhinopithecu… MEEPQSDPSVEPPL…
#>  5 2022-05-25 23:24:04 ENSP00000269… ENSRBIP00000… rhinopithecu… MEEPQSDPSVEPPL…
#>  6 2022-05-25 23:24:04 ENSP00000269… ENSCSAP00000… chlorocebus_… MEEPQSDPSVEPPL…
#>  7 2022-05-25 23:24:04 ENSP00000269… ENSMFAP00000… macaca_fasci… MEEPQSDPSVEPPL…
#>  8 2022-05-25 23:24:04 ENSP00000269… ENSMMUP00000… macaca_mulat… --------------…
#>  9 2022-05-25 23:24:04 ENSP00000269… ENSPANP00000… papio_anubis  MEEPQSDPSVEPPL…
#> 10 2022-05-25 23:24:04 ENSP00000269… ENSCATP00000… cercocebus_a… MEEPQSDPSVEPPL…
#> # ℹ 244 more rows
#> # ℹ 5 more variables: ortho_align_seq <chr>, human_ortho_perc_id <dbl>,
#> #   ortho_human_perc_id <dbl>, human_profile_seq <chr>, ortho_profile_seq <chr>
```

The column `ortho_profile_seq` contains the ortholog sequences of the
profile. The human sequence is the same across rows and can be found in
the column `human_profile_seq`:

``` r
tp53_prof[c("ortho_species", "human_profile_seq", "ortho_profile_seq")]
#> # A tibble: 254 × 3
#>    ortho_species           human_profile_seq                   ortho_profile_seq
#>    <chr>                   <chr>                               <chr>            
#>  1 pan_paniscus            MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSVEPPLSQ…
#>  2 pan_troglodytes         MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSVEPPLSQ…
#>  3 pongo_abelii            MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSVEPPLSQ…
#>  4 rhinopithecus_roxellana MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#>  5 rhinopithecus_bieti     MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#>  6 chlorocebus_sabaeus     MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#>  7 macaca_fascicularis     MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#>  8 macaca_mulatta          MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#>  9 papio_anubis            MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLSQ…
#> 10 cercocebus_atys         MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP… MEEPQSDPSIEPPLRQ…
#> # ℹ 244 more rows
```
