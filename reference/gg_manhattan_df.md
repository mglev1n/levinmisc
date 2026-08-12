# Create a Manhattan Plot

This function is a wrapper around ggfastman::fast_manhattan which allows
for the creation of a Manhattan plot from a dataframe containing GWAS
summary statistics. It handles p-value underflow by calculating -log10
p-values directly from beta and standard error when available.

## Usage

``` r
gg_manhattan_df(
  sumstats_df,
  annotation_df = NULL,
  chr_col = chromosome,
  pos_col = position,
  pval_col = p_value,
  beta_col = NULL,
  se_col = NULL,
  pval_threshold = 0.001,
  log10p_threshold = 3,
  label_col = gene,
  build = "hg19",
  color1 = "#045ea7",
  color2 = "#82afd3",
  speed = "slow",
  ...
)
```

## Arguments

- sumstats_df:

  Dataframe containing GWAS summary statistics

- annotation_df:

  Optional dataframe containing chromosome, position, and annotation
  labels

- chr_col:

  Name of chromosome column

- pos_col:

  Name of position column

- pval_col:

  Name of p-value column (used when beta_col and se_col are not
  provided)

- beta_col:

  Name of beta (effect size) column (optional, used with se_col to avoid
  p-value underflow)

- se_col:

  Name of standard error column (optional, used with beta_col to avoid
  p-value underflow)

- pval_threshold:

  Threshold for plotting p-values (p-values greater than this value are
  excluded from the plot; default = `0.001`)

- log10p_threshold:

  Threshold for plotting -log10 p-values when using beta/se (default =
  `3`, equivalent to p \< 0.001)

- label_col:

  Name of column in `annotation_df` containing annotations to include on
  the plot

- build:

  (string) One of "hg18", "hg19", or "hg38" (passed to `ggfastman`)

- color1:

  (string) Color for odd-numbered chromosomes (passed to `ggfastman`)

- color2:

  (string) Color for even-numbered chromosomes (passed to `ggfastman`)

- speed:

  (string) One of "slow", "fast", or "ultrafast"; passed to `ggfastman`
  to control plotting speed

- ...:

  Arguments passed to ggfastman::fast_manhattan

## Value

A ggplot2 object

## See also

Other plotting:
[`gg_qq_df()`](https://mglev1n.github.io/levinmisc/reference/gg_qq_df.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Using p-values directly
gg_manhattan_df(sumstats_df)

# Using beta and se to avoid p-value underflow
gg_manhattan_df(sumstats_df, beta_col = beta, se_col = se)
} # }
```
