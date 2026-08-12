# Run a TWAS using S-PrediXcan

This function is a wrapper around S-PrediXcan, a method of integrating
GWAS summary statistics with gene-expression/splicing data to identify
genes associated with a trait. The PrediXcan/MetaXcan method is
described in Barbeira et al. (Nature Communications 2018;
<https://doi.org/10.1038/s41467-018-03621-1>). The MetaXcan tools can be
found on Github (<https://github.com/hakyimlab/MetaXcan>) and PredictDB
(<https://predictdb.org/>). If S-PrediXcan is run across multiple
tissues, the results can be integrated using
[`s_multixcan()`](https://mglev1n.github.io/levinmisc/reference/s_multixcan.md).

## Usage

``` r
s_predixcan(
  df,
  snp = SNP,
  effect_allele = effect_allele,
  other_allele = other_allele,
  beta = beta,
  eaf = eaf,
  chr = chr,
  pos = pos,
  se = se,
  pval = pval,
  samplesize = samplesize,
  data,
  metaxcan,
  output,
  model_db_path,
  model_covariance_path,
  trait_name
)
```

## Arguments

- df:

  Dataframe containing GWAS summary statistics

- snp:

  Column containing rsid

- effect_allele:

  Column containing effect allele

- other_allele:

  Column containing non-effect allele

- beta:

  Column containing effect size

- eaf:

  Column containing effect allele frequency

- chr:

  Column containing chromosome

- pos:

  Column containing position

- se:

  Column containing standard error of the effect estimate

- pval:

  Column containing p-value

- samplesize:

  Column containing samplesize

- data:

  Path to MetaXcan data (eg. `"MetaXcan/data"`)

- metaxcan:

  Path to MetaXcan (eg. `"MetaXcan/software"`)

- output:

  Output directory to save S-PrediXcan results

- model_db_path:

  Path to PrediXcan model database

- model_covariance_path:

  Path to PrediXcan model covariance

- trait_name:

  Name of GWAS trait (used to name output files)

## Value

A dataframe containing the S-PrediXcan results

## See also

Other TWAS:
[`s_multixcan()`](https://mglev1n.github.io/levinmisc/reference/s_multixcan.md)

Other Gene-based testing:
[`magmar()`](https://mglev1n.github.io/levinmisc/reference/magmar.md),
[`s_multixcan()`](https://mglev1n.github.io/levinmisc/reference/s_multixcan.md)

## Examples

``` r
if (FALSE) { # \dontrun{
s_predixcan(df, data = "MetaXcan/data", metaxcan = "MetaXcan/software", output = "/path/to/output", model_db_path = "MetaXcan/data/models/eqtl/mashr/mashr_Liver.db", model_covariance_path = "MetaXcan/data/models/eqtl/mashr/mashr_Liver.txt.gz", trait_name = "GWAS_trait")
} # }
```
