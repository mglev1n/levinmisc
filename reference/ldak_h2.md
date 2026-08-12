# Calculate heritability using LDAK

This function wraps LDAK, a command-line tool for estimating
heritability. The tool and associated reference files can be download
from the LDAK website (<https://ldak.org/>). The method is described in
Zhang et al. (Nature Communications 2021;
\<https://doi.org/10.1038/s41467-021-24485-y).

## Usage

``` r
ldak_h2(
  sumstats_file,
  ldak_bin,
  ldak_tagfile,
  sample_prev = NULL,
  population_prev = NULL,
  hm3_file,
  ldak_cutoff = 0.01
)
```

## Arguments

- sumstats_file:

  Path to "munged" GWAS summary statistics file in LDSC format. The
  current implementation of this function requires rsids to link to
  other LDAK files.

- ldak_bin:

  Path to LDAK binary

- ldak_tagfile:

  Path to LDAK tagfile

- sample_prev:

  Sample prevalence of cases (for case-control studies), `NULL`
  (default) for quantitative traits

- population_prev:

  Population prevalence of cases in the sample (for case-control
  studies), `NULL` (default) for quantitative traits

- hm3_file:

  Path to hm3 file containing

- ldak_cutoff:

  Minor allele frequency cutoff (default = 0.01)

## Value

List of dataframes containing LDAK results

## Examples

``` r
if (FALSE) { # \dontrun{
ldak_h2(sumstats_file = "/path/to/munged_sumstats", ldak_bin = "/path/to/ldak", ldak_tagfile = "/path/to/tagfile",  hm3_file = "/path/to/hm3")
} # }
```
