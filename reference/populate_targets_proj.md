# Create a minimal targets template in the current project

This function creates a minimal targets template in the current
directory. This includes creating a `Pipelines.qmd` file containing
boilerplate for running analyses, and a `Results.qmd` file which can be
used to visualize the results. Parallelization of the pipeline is
implemented using `targets::tar_make()` and `crew.cluster`, using
pre-filled using parameters specific to the LPC system at Penn.

The `runtime` argument selects the R installation the pipeline runs
against, and is passed through to
[`use_crew_lsf()`](https://mglev1n.github.io/levinmisc/reference/use_crew_lsf.md).
`"native"`, the default, loads the LPC's R module and leaves the package
library to `renv`; `"container"` instead runs the main `targets` process
and every worker inside the LPC's RStudio Singularity image.

## Usage

``` r
populate_targets_proj(
  title,
  log_folder = "build_logs",
  runtime = c("native", "container"),
  overwrite = FALSE
)
```

## Arguments

- title:

  (character) base name for project files (eg. "title-Pipeline.qmd" and
  "title-Results.qmd")

- log_folder:

  (character) directory for LSF logs

- runtime:

  (character) R runtime the pipeline and its LSF workers use: `"native"`
  (the default) for the module-provided R, or `"container"` for the LPC
  RStudio Singularity image

- overwrite:

  (logical) overwrite existing template files

## Examples

``` r
if (FALSE) { # \dontrun{
populate_targets_proj("test")
populate_targets_proj("test", runtime = "container")
} # }
```
