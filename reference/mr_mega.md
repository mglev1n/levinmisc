# Perform multi-ancestry GWAS meta-analysis using MR-MEGA

This function is a wrapper around MR-MEGA, which uses meta-regression to
combine GWAS summart statistics while accounting for
study/population-specific components of genetic variation. The method
was described in Magi et al. (Human Molecular Genetics 2017;
<https://doi.org/10.1093/hmg/ddx280>), and the package can be obtained
from the Estonian Genome Centre (<https://genomics.ut.ee/en/tools>).

## Usage

``` r
mr_mega(
  sumstats_files,
  mr_mega_bin,
  marker_col = MARKER,
  chr_col = CHROM,
  pos_col = POS,
  effect_allele_col = EFFECT_ALLELE,
  other_allele_col = OTHER_ALLELE,
  eaf_col = EAF,
  beta_col = BETA,
  se_col = SE,
  p_value_col = P,
  samplesize_col = N,
  n_pcs = 3
)
```

## Arguments

- sumstats_files:

  List of files containing GWAS summary statistics. These files should
  all contain the same column header.

- mr_mega_bin:

  Path to MR-MEGA binary

- marker_col:

  Column containing unique markers for each variant

- chr_col:

  Column containing the chromosome

- pos_col:

  Column containing the position

- effect_allele_col:

  Column containing the effect allele

- other_allele_col:

  Column containing the non-effect allele

- eaf_col:

  Column containing effect allele frequencies

- beta_col:

  Column containing effect estimates

- se_col:

  Column containing standard errors

- p_value_col:

  Column containing p-value

- samplesize_col:

  Column containing sample size

- n_pcs:

  Number of genetic principal components to include in the
  meta-regression.

## Value

A data.frame containing the GWAS summary statistics from the
meta-regression

## See also

Other GWAS meta-analysis:
[`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md),
[`metal_run()`](https://mglev1n.github.io/levinmisc/reference/metal_run.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mr_mega(sumstats_files = list("/path/to/sumstats_1.txt.gz", "/path/to/sumstats_2.txt.gz"), mr_mega_bin = "/path/to/MR-MEGA")
} # }
```
