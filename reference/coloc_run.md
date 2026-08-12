# Run Bayesian enumeration colocalization using Coloc

This function is a wrapper around `coloc::coloc.abf()` that takes a
dataframe as input, and performs colocalization under the
single-causal-variant assumption. Coloc was described in Giambartolomei
et al. (PLOS Genetics 2014;
<https://doi.org/10.1371/journal.pgen.1004383>).

## Usage

``` r
coloc_run(
  df,
  trait_col = trait,
  variant_col = rsid,
  beta_col = beta,
  se_col = se,
  samplesize_col = samplesize,
  maf_col = maf,
  type_col = type,
  case_prop_col = case_prop,
  p1 = 1e-04,
  p2 = 1e-04,
  p12 = 1e-05,
  ...
)
```

## Arguments

- df:

  Dataframe containing summary statistics at a single locus for two
  traits in a "long" format, with one row per variant per trait.

- trait_col:

  Column containing trait names

- variant_col:

  Column containing unique variant identifiers (Eg. rsids, chr:pos)

- beta_col:

  Column containing effect estimates

- se_col:

  Column containing standard errors

- samplesize_col:

  Column containing sample sizes

- maf_col:

  Column containing minor allele frequencies

- type_col:

  Column containing the type of each trait ("quant" for quantitative
  traits, "cc" for binary traits)

- case_prop_col:

  Column containing the proportion of cases for case control studies;
  this column is ignored for quantitative traits

- p1:

  Prior probability a SNP is associated with trait 1, default 1e-4

- p2:

  Prior probability a SNP is associated with trait 2, default 1e-4

- p12:

  Prior probability a SNP is associated with both traits, default 1e-5

- ...:

  Arguments passed to `coloc::coloc.abf()`

## Value

A list containing coloc results.

- `summary` is a named vector containing the number of snps, and the
  posterior probabilities of the 5 colocalization hypotheses

- `results` is an annotated version of the input data containing log
  approximate Bayes Factors and posterior probability of each SNP being
  causal if H4 is true.

## See also

Other colocalization:
[`hyprcoloc_df()`](https://mglev1n.github.io/levinmisc/reference/hyprcoloc_df.md)

## Examples

``` r
if (FALSE) { # \dontrun{
coloc_run(locus_df)
} # }
```
