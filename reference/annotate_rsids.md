# Annotate a dataframe containing genomic coordinates with rsids

This function can be used rapidly add rsids to GWAS summary statistics
or any other dataframe containing genomic coordinates (eg. chromosome
and position). This is a rapid function that does not explicitly account
for differences in variants at each position, strand flips, etc.)

## Usage

``` r
annotate_rsids(
  df,
  dbSNP = SNPlocs.Hsapiens.dbSNP144.GRCh37::SNPlocs.Hsapiens.dbSNP144.GRCh37,
  chrom_col = Chromosome,
  pos_col = Position
)
```

## Arguments

- df:

  Dataframe containing genomic coordinates to annotate with rsid

- dbSNP:

  Bioconductor object containing SNP locations and alleles to be used
  for annotation (default:
  `SNPlocs.Hsapiens.dbSNP144.GRCh37::SNPlocs.Hsapiens.dbSNP144.GRCh37`)

- chrom_col:

  Chromosome column

- pos_col:

  Position column

## Value

A dataframe containing the original contents, with an additional `rsid`
column.

## Examples

``` r
if (FALSE) { # \dontrun{
annotate_rsids(sumstats_df)
} # }
```
