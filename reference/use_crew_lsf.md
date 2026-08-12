# Use crew lsf to execute a targets pipeline using the LSF HPC scheduler

**\[experimental\]**

This function returns a template for using `crew.cluster` in a targets
project, enabling the parallel execution of a targets workflow. By
default, the template is pre-filled using parameters specific to the LPC
system at Penn. By default, this function creates workers that submit to
different queues (eg. `voltron_normal`, `voltron_long`), and allocate
different resources (eg. a "normal" worker will use 1 core and 16GB
memory, while a "long" worker will use 1 core and 10GB memory).

## Usage

``` r
use_crew_lsf()
```

## Value

A code block to copy/paste into a targets project

## Examples

``` r
if (FALSE) { # \dontrun{
use_crew_lsf()
} # }
```
