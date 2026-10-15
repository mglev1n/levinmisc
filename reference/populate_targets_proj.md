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

The `"container"` runtime still works but will lose support in a future
release; new projects should use `"native"`.

The function also creates a data directory and a results directory, so
that every location holding data or data-derived output is known when
the project starts. With `git_safeguards = TRUE` (the default), it keeps
those locations out of git in two ways. It appends entries to
`.gitignore` for the data and results directories, the log directory,
the `targets` data store (`_targets/`), the scripts generated from the
Target Markdown file, and common data file types. Rendered HTML reports
are not ignored, so they can be committed once checked. It also writes a
pre-commit hook to `.githooks/pre-commit` that refuses any commit
staging a file from those directories, a file with a data file
extension, a file larger than 5 MB (25 MB for HTML), or text shaped like
a PMBB participant ID, including IDs inside SVG figures embedded in a
self-contained report. The hook prints only masked identifiers. When
`path` is the root of a git repository, the function points
`core.hooksPath` at `.githooks` so the hook runs; otherwise it prints
the command to run after `git init`. Because the hook lives in the
repository, each new clone needs only that one command.

The function writes `.vscode/tasks.json`, which defines editor tasks for
pulling from GitHub, rendering the pipeline file, and running the
pipeline, plus one task that runs all three in sequence. The run task
calls `.run-pipeline.R`, which runs `targets::tar_make()` and sends an
optional Slack or ntfy notification when the pipeline completes or
fails. The notification holds only the status, elapsed time, target
counts, and errored target names, never error text, and is configured
per user in `~/.Renviron` (see the vignette). The tasks work in VS Code
and code-server when the project directory is opened as the workspace
and trusted; an existing `tasks.json` is left unchanged. A run started
from a task stops if the code-server job ends.

The function can be re-run on an existing project to add files
introduced by newer versions of this package. Existing files are kept
unless `overwrite = TRUE`, and when `title` is not given, an existing
`*-Pipeline.qmd` file supplies it. The pre-commit hook is the exception:
it is always updated to the current version, and a previous hook that
differs is saved as `.githooks/pre-commit.bak`.

The LSF submission scripts `submit-targets.sh` and `.make-targets.sh`
are written only when `lsf_scripts = TRUE`, for users who start
pipelines from a submission host rather than from code-server on a
compute node.

## Usage

``` r
populate_targets_proj(
  title,
  log_folder = "build_logs",
  path = ".",
  runtime = c("native", "container"),
  overwrite = FALSE,
  data_dir = "Data",
  results_dir = "Results",
  git_safeguards = TRUE,
  lsf_scripts = FALSE
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

  (logical) replace existing project files (the pipeline and results
  `.qmd` files, `.run-pipeline.R`, `.vscode/tasks.json`, and the LSF
  scripts) with fresh templates. By default, existing files are kept and
  only missing files are added.

- data_dir:

  (character) directory for input data, created inside `path` and
  excluded from git

- results_dir:

  (character) directory for pipeline results, created inside `path` and
  excluded from git

- git_safeguards:

  (logical) add `.gitignore` entries and a pre-commit hook that keep
  data, results, and participant identifiers out of git

- lsf_scripts:

  (logical) also write `submit-targets.sh` and `.make-targets.sh` for
  submitting the main `targets` process as an LSF job. The log folder is
  created either way, since `crew` LSF workers write their logs there.

## Examples

``` r
if (FALSE) { # \dontrun{
populate_targets_proj("test")
populate_targets_proj("test", runtime = "container")
} # }
```
