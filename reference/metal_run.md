# Use METAL to run a GWAS meta-analysis

This function is a wrapper for METAL, a tool for performing
meta-analysis of GWAS summary statistics
<https://github.com/statgen/METAL>. Details of the arguments to METAL
are described in the METAL documentation:
<https://genome.sph.umich.edu/wiki/METAL_Documentation>.

## Usage

``` r
metal_run(config_file, metal_path)
```

## Arguments

- config_file:

  (path) Path to a METAL configuration file (this can be generated using
  [`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md))

- metal_path:

  (path) Path to the METAL binary

## Value

Path to gzip-formatted text file containing meta-analysis summary
statistics

## See also

Create a METAL configuration file:
[`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md)

Other GWAS meta-analysis:
[`metal_config()`](https://mglev1n.github.io/levinmisc/reference/metal_config.md),
[`mr_mega()`](https://mglev1n.github.io/levinmisc/reference/mr_mega.md)

## Examples

``` r
if (FALSE) { # \dontrun{
metal_run(config_file = "config.txt", metal_path = "/path/to/metal_binary")
} # }
```
