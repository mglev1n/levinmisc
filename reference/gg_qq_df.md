# Create a QQ plot

This function is a wrapper around ggfastman::fast_qq which allows for
the creation of a QQ plot from a dataframe containing GWAS summary
statistics.

## Usage

``` r
gg_qq_df(sumstats_df, pval_col = p_value, ...)
```

## Arguments

- sumstats_df:

  Dataframe containing GWAS summary statistics

- pval_col:

  Name of p-value column

- ...:

  Arguments passed to ggfastman::fast_qq

## Value

A ggplot2 object

## See also

Other plotting:
[`gg_manhattan_df()`](https://mglev1n.github.io/levinmisc/reference/gg_manhattan_df.md)

## Examples

``` r
if (FALSE) { # \dontrun{
gg_qq_df(sumstats_df)
} # }
```
