
# levinmisc

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mglev1n/levinmisc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mglev1n/levinmisc/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

A set of miscellaneous convenience functions.

## Installation

You can install the development version of `levinmisc` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mglev1n/levinmisc")
```

The `levinmisc` package currently has a large number of dependencies, and may take a long time to install. Installation using the `pak` package has been tested and avoids timeout errors that may occur when installing the package using `devtools::install_github()`.

> [!TIP]
> Installation of `levinmisc` may have errors related to installtion of other packages. If you encounter such errors, try installing the packages manually. For example, on some systems there is a known issue with installation of the `hyprcoloc` package: https://github.com/jrs95/hyprcoloc/issues/30. If this occurs, try following these steps: https://github.com/jrs95/hyprcoloc/issues/30#issuecomment-2002027048
