# Run multi-trait colocalization using HyPrColoc

This function is a convenience wrapper around `hyprcoloc::hyprcoloc()`
that takes a dataframe as input, and performs mutli-trait
colocalization. Details of the HyPrColoc method are described in Foley
et al. (Nature Communications 2021;
<https://doi.org/10.1038/s41467-020-20885-8>).

## Usage

``` r
hyprcoloc_df(
  df,
  trait_col = trait,
  snp_col = rsid,
  beta_col = beta,
  se_col = se,
  type_col = type,
  ...
)
```

## Arguments

- df:

  Dataframe containing summary statistics at a single locus, in a "long"
  format, with one row per variant per trait.

- trait_col:

  Column containing trait names

- snp_col:

  Column containing variant names (eg. rsid, marker_name), which should
  be consistent across studies

- beta_col:

  Column containing effect estimates from GWAS

- se_col:

  Column containing standard errors of the effect estimates

- type_col:

  Column containing the "type" of trait - this column should contain `1`
  for binary traits, and `0` for all others

- ...:

  Arguments passed to `hyprcoloc::hyprcoloc()`

## Value

A list containing a data.frame of HyPrColoc results: each row is a
cluster of colocalized traits or is coded NA (if no colocalization is
identified)

## See also

Other colocalization:
[`coloc_run()`](https://mglev1n.github.io/levinmisc/reference/coloc_run.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hyprcoloc_df(gwas_results_df)
} # }
```
