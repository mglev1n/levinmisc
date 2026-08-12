# Perform Bayesian finemapping using the Approximate Bayes Factor approach

Description

## Usage

``` r
calc_credset(
  df,
  locus_marker_col = locus_marker,
  effect_col = effect,
  se_col = std_err,
  samplesize_col = samplesize,
  cred_interval = 0.99
)
```

## Arguments

- df:

  Dataframe containing GWAS summary statistics

- locus_marker_col:

  Column containing a locus-level identifier

- effect_col:

  Column containing effect estimates

- se_col:

  Column containing standard errors fo the effect estimates

- samplesize_col:

  Column containing sample sizes

- cred_interval:

  Credible interval for the fine-mapped credible sets (default = 0.99;
  0.95 is another common but artbitrarily determined interval)

## Value

A data.frame containing credible sets at each locus. For each variant
within the credible set, the prior probability of being the casual
variant is provided.

## Examples

``` r
if (FALSE) { # \dontrun{
calc_credset(gwas_df)
} # }
```
