# Use crew lsf to execute a targets pipeline using the LSF HPC scheduler

**\[experimental\]**

This function returns a template for using `crew.cluster` in a targets
project, enabling the parallel execution of a targets workflow. By
default, the template is pre-filled using parameters specific to the LPC
system at Penn. By default, this function creates workers that submit to
different queues (eg. `voltron_normal`, `voltron_long`), and allocate
different resources (eg. a "normal" worker will use 1 core and 16GB
memory, while a "long" worker will use 1 core and 10GB memory).

The `runtime` argument selects the R installation the workers run
against. `"native"`, the default, loads the LPC's R module and leaves
the package library to `renv`; `"container"` runs each worker inside the
LPC's RStudio Singularity image instead. Use `"container"` only when the
project library was built against that image: a worker that loads a
library built for a different R version fails with errors such as
`unused arguments (controller = ...)`, because the worker and the
controller then run different `crew` versions.

## Usage

``` r
use_crew_lsf(runtime = c("native", "container"))
```

## Arguments

- runtime:

  (character) R runtime the LSF workers use: `"native"` (the default)
  for the module-provided R, or `"container"` for the LPC RStudio
  Singularity image

## Value

A code block to copy/paste into a targets project

## Examples

``` r
if (FALSE) { # \dontrun{
use_crew_lsf()
use_crew_lsf(runtime = "container")
} # }
```
