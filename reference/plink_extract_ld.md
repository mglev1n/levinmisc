# Extract an LD matrix from a reference panel using plink 1.9

Extract an LD matrix from a reference panel using plink 1.9

## Usage

``` r
plink_extract_ld(
  df,
  snp_col,
  effect_allele_col,
  metric = "r",
  bfile,
  threads = 1,
  memory = 16000,
  plink_bin
)
```

## Arguments

- df:

  Dataframe containing variants to be included in the LD matrix; must
  contain SNP identifier and effect allele

- snp_col:

  Name of column containing SNP identifiers

- effect_allele_col:

  Name of column containing effect alleles (used when considering signed
  measures of LD like `r`)

- metric:

  LD metric - either `r` (which will return a signed correlation matrix)
  or `r2` (which will return squared correlations)

- bfile:

  Path to plink `bfile` that will be used to extract LD

- threads:

  Number of threads (default = 1)

- memory:

  Memory limit (default = 16000 MB)

- plink_bin:

  Path to plink executable

## Value

A square matrix containing the pairwise correlations between genetic
variants

## Examples

``` r
if (FALSE) { # \dontrun{
plink_extract_ld(df, snp_col, effect_allele_col, metric = "r", bfile = "/path/to/reference/panel/", plink_bin = "/path/to/plink1.9")
} # }
```
