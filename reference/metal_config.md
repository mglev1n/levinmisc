# Create a configuration file for METAL

This function can be used to generate a configuration for METAL, a tool
for performing meta-analysis of GWAS summary statistics
<https://github.com/statgen/METAL>. The file created by this function
can be used to run a meta-analysis. Details of the arguments to METAL
are described in the METAL documentation:
<https://genome.sph.umich.edu/wiki/METAL_Documentation>.

## Usage

``` r
metal_config(
  config_name,
  output_dir,
  study_files,
  SCHEME = "STDERR",
  AVERAGEFREQ = "ON",
  MINMAXFREQ = "OFF",
  TRACKPOSITIONS = "ON",
  MARKERLABEL = "MARKER",
  CHROMOSOMELABEL = "CHROM",
  POSITIONLABEL = "POS",
  EFFECT_ALLELE = "EFFECT_ALLELE",
  OTHER_ALLELE = "OTHER_ALLELE",
  EFFECTLABEL = "BETA",
  STDERR = "SE",
  FREQLABEL = "EAF",
  NCASE = NULL,
  NCONTROL = NULL,
  SAMPLESIZE = NULL
)
```

## Arguments

- config_name:

  (string) Name of the configuration

- output_dir:

  (path) Path to output directory where GWAS meta-analysis data should
  be stored

- study_files:

  (vector) Character vector of paths to summary statistics that should
  be included in the GWAS

- SCHEME:

  (string) Either "SAMPLESIZE" or "STDERR" (default), corresponding to
  the METAL analysis scheme

- AVERAGEFREQ:

  (string) Either "ON" (default) or "OFF", allowing METAL to report the
  mean effect allele frequency across files

- MINMAXFREQ:

  (string) Either "ON" (default) or "OFF", allowing METAL to report the
  min/max effect allele frequency across files

- TRACKPOSITIONS:

  (string) Either "ON" (default) or "OFF", allowing METAL to report
  chromosome/position in the output

- MARKERLABEL:

  (string) Column containing unique markers to analyze (this column must
  be named the same across all input files)

- CHROMOSOMELABEL:

  (string) Column containing chromosomes (this column must be named the
  same across all input files)

- POSITIONLABEL:

  (string) Column containing genomic positions (this column must be
  named the same across all input files)

- EFFECT_ALLELE:

  (string) Column containing effect alleles (this column must be named
  the same across all input files)

- OTHER_ALLELE:

  (string) Column containing non-effect alleles (this column must be
  named the same across all input files)

- EFFECTLABEL:

  (string) Column containing effect sizes corresponding to the effect
  allele (this column must be named the same across all input files)

- STDERR:

  (string) Column containing standard errors fo the effect estimate
  (this column must be named the same across all input files)

- FREQLABEL:

  (string) Column containing effect allele frequencies (this column must
  be named the same across all input files)

- NCASE:

  (string) Column containing number of cases (this column must be named
  the same across all input files)

- NCONTROL:

  (string) Column containing number of controls (this column must be
  named the same across all input files)

- SAMPLESIZE:

  (string) Column containing total samplesize (this column must be named
  the same across all input files)

## Value

Path to METAL configuration file

## See also

Run GWAS meta-analysis using METAL:
[`metal_run()`](https://mglev1n.github.io/levinmisc/reference/metal_run.md)

Other GWAS meta-analysis:
[`metal_run()`](https://mglev1n.github.io/levinmisc/reference/metal_run.md),
[`mr_mega()`](https://mglev1n.github.io/levinmisc/reference/mr_mega.md)

## Examples

``` r
if (FALSE) { # \dontrun{
metal_config(config_name = "name-of-analysis", output_dir = "/path/to/output/", study_files = c("/path/to/sumstats_1.txt", "/path/to/sumstats_2.txt"))
} # }
```
