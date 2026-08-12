# Run MAGMA gene-based analysis

This function provides a wrapper to MAGMA, which performs gene-based
testing from GWAS summary statistics. Details of MAGMA described in de
Leeuw et al. (PLoS Cumputational Biology 2015;
<https://doi.org/10.1371/journal.pcbi.1004219>). The MAGMA binary and
reference files are available from the Complex Trait Genetics lab
(<https://ctg.cncr.nl/software/magma>).

## Usage

``` r
magmar(
  sumstats_df,
  pval_col = p_value,
  snp_col = rsid,
  samplesize_col = samplesize,
  magma_bin,
  bfile,
  gene_file,
  out_file
)
```

## Arguments

- sumstats_df:

  Dataframe containing GWAS summary statistics

- pval_col:

  Column containing p-values

- snp_col:

  Column containing rsids

- samplesize_col:

  Column containing sample size

- magma_bin:

  Path to MAGMA binary

- bfile:

  Path to reference data in plink `bfile` format (path should not
  include the extensions)

- gene_file:

  Path to file containing gene locations

- out_file:

  Output directory + file prefix

## Value

Path to MAGMA results file

## See also

Other Gene-based testing:
[`s_multixcan()`](https://mglev1n.github.io/levinmisc/reference/s_multixcan.md),
[`s_predixcan()`](https://mglev1n.github.io/levinmisc/reference/s_predixcan.md)

## Examples

``` r
if (FALSE) { # \dontrun{
magmar(sumstats_df, magma_bin = "/path/to/magma", bfile = "/path/to/bfiles", gene_file = "/path/to/genes", out_file = "magma_output")
} # }
```
