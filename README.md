
<!-- README.md is generated from README.Rmd. Please edit that file -->

# protean

<!-- badges: start -->
<!-- badges: end -->

This package contains provides protein sequence profiles for OncoKB
cancer genes.

These sequence profiles can be useful to infer evolutionary variation at
protein positions which in turn may be used as a proxy for inferring
impact of mutations.

## Installation

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
#> [1] "/home/rmagno/R/x86_64-pc-linux-gnu-library/4.1/protean/profiles/TP53.csv.gz"
```

To import one sequence profile into R use `read_profile()`:

``` r
tp53_prof <- read_profile(profile_path("TP53"))
tp53_prof
#> # A tibble: 254 × 10
#>    timestamp           human_prot_id ortho_prot_id ortho_species human_align_seq
#>    <chr>               <chr>         <chr>         <chr>         <chr>          
#>  1 2022-05-25 23:24:04 ENSP00000269… ENSGGOP00000… gorilla_gori… MEEPQSDPSVEPPL…
#>  2 2022-05-25 23:24:04 ENSP00000269… ENSPPAP00000… pan_paniscus  MEEPQSDPSVEPPL…
#>  3 2022-05-25 23:24:04 ENSP00000269… ENSPPYP00000… pongo_abelii  --------------…
#>  4 2022-05-25 23:24:04 ENSP00000269… ENSPTRP00000… pan_troglody… MEEPQSDPSVEPPL…
#>  5 2022-05-25 23:24:04 ENSP00000269… ENSNLEP00000… nomascus_leu… MEEPQSDPSVEPPL…
#>  6 2022-05-25 23:24:04 ENSP00000269… ENSOANP00000… ornithorhync… --------------…
#>  7 2022-05-25 23:24:04 ENSP00000269… ENSSHAP00000… sarcophilus_… --------------…
#>  8 2022-05-25 23:24:04 ENSP00000269… ENSMEUP00000… notamacropus… MEEPQSDPSVEPPL…
#>  9 2022-05-25 23:24:04 ENSP00000269… ENSDNOP00000… dasypus_nove… --MEEPQSDPSVEP…
#> 10 2022-05-25 23:24:04 ENSP00000269… ENSEEUP00000… erinaceus_eu… MEEPQSDPSVEPPL…
#> # … with 244 more rows, and 5 more variables: ortho_align_seq <chr>,
#> #   human_ortho_perc_id <dbl>, ortho_human_perc_id <dbl>,
#> #   human_profile_seq <chr>, ortho_profile_seq <chr>
```

The column `ortho_profile_seq` contains the ortholog sequences of the
profile. The human sequence is the same across rows and can be found in
the column `human_profile_seq`:

``` r
tp53_prof[c("ortho_species", "human_profile_seq", "ortho_profile_seq")]
#> # A tibble: 254 × 3
#>    ortho_species            human_profile_seq          ortho_profile_seq        
#>    <chr>                    <chr>                      <chr>                    
#>  1 gorilla_gorilla          MEEPQSDPSVEPPLSQETFSDLWKL… ------------------------…
#>  2 pan_paniscus             MEEPQSDPSVEPPLSQETFSDLWKL… MEEPQSDPSVEPPLSQETFSDLWK…
#>  3 pongo_abelii             MEEPQSDPSVEPPLSQETFSDLWKL… MEEPQSDPSVEPPLSQETFSDLWK…
#>  4 pan_troglodytes          MEEPQSDPSVEPPLSQETFSDLWKL… MEEPQSDPSVEPPLSQETFSDLWK…
#>  5 nomascus_leucogenys      MEEPQSDPSVEPPLSQETFSDLWKL… MEEPQSDPSVEPPLSQETFSDLWK…
#>  6 ornithorhynchus_anatinus MEEPQSDPSVEPPLSQETFSDLWKL… PDPPQADCSGEPPLSQETFLDLWQ…
#>  7 sarcophilus_harrisii     MEEPQSDPSVEPPLSQETFSDLWKL… MEESLSDL--EPPLSQETFSDLWK…
#>  8 notamacropus_eugenii     MEEPQSDPSVEPPLSQETFSDLWKL… ------------------------…
#>  9 dasypus_novemcinctus     MEEPQSDPSVEPPLSQETFSDLWKL… MEEPPSDLSIEAPLSQETFSDLWK…
#> 10 erinaceus_europaeus      MEEPQSDPSVEPPLSQETFSDLWKL… MEDLPLELDVDTPLSQTTFSELWN…
#> # … with 244 more rows
```
