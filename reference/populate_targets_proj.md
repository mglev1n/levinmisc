# Create a minimal targets template in the current project

This function creates a minimal targets template in the current
directory. This includes creating a `Pipelines.qmd` file containing
boilerplate for running analyses, and a `Results.qmd` file which can be
used to visualize the results. Parallelization of the pipeline is
implemented using `targets::tar_make()` and `crew.cluster`, using
pre-filled using parameters specific to the LPC system at Penn.

Files are written to `path`, which defaults to the working directory.
Passing it explicitly matters when the project directory holds none of
the markers a project search looks for (an `.Rproj` file, a
`DESCRIPTION`, a git repository, a `.vscode/` directory), because such a
search otherwise walks up and writes into a parent directory.

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
  path = ".",
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

- path:

  (character) project directory the files are written to, defaulting to
  the working directory

- runtime:

  (character) R runtime the pipeline and its LSF workers use: `"native"`
  (the default) for the module-provided R, or `"container"` for the LPC
  RStudio Singularity image

- overwrite:

  (logical) replace existing template files without asking first

## Examples

``` r
if (FALSE) { # \dontrun{
populate_targets_proj("test")
populate_targets_proj("test", runtime = "container")
} # }
```
