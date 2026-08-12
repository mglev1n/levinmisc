# Create a minimal targets template in the current project

This function creates a minimal targets template in the current
directory. This includes creating a `Pipelines.qmd` file containing
boilerplate for running analyses, and a `Results.qmd` file which can be
used to visualize the results. Parallelization of the pipeline is
implemented using `targets::tar_make()` and `crew.cluster`, using
pre-filled using parameters specific to the LPC system at Penn.

## Usage

``` r
populate_targets_proj(title, log_folder = "build_logs", overwrite = FALSE)
```

## Arguments

- title:

  (character) base name for project files (eg. "title-Pipeline.qmd" and
  "title-Results.qmd")

- log_folder:

  (character) directory for LSF logs

- overwrite:

  (logical) overwrite existing template files

## Examples

``` r
if (FALSE) { # \dontrun{
populate_targets_proj("test")
} # }
```
