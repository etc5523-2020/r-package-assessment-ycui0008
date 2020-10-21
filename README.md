
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covid19ViewerShiny

<!-- badges: start -->

[![R build
status](https://github.com/etc5523-2020/r-package-assessment-ycui0008/workflows/R-CMD-check/badge.svg)](https://github.com/etc5523-2020/r-package-assessment-ycui0008/actions)
<!-- badges: end -->

The goal of `covid19ViewerShiny` is to monitor global covid-19 cases and
deaths, and it can compare the covid-19 cases in different countries.
The package contains map information — thus, it would take some time
when you run it at beginning or you change date input in `Map` tab of
the app.

## Installation

You can install the released version of `covid19ViewerShiny` from
[GitHub](https://github.com/etc5523-2020/r-package-assessment-ycui0008)
with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-ycui0008")
```

## Dataset example

This is a basic example which shows you how the dataset `covid`
contained in the package looks like:

``` r
library(covid19ViewerShiny)
library(tibble)
covid
#> # A tibble: 68,150 x 8
#>    date_reported country_code country who_region new_cases cumulative_cases
#>    <date>        <chr>        <chr>   <chr>          <dbl>            <dbl>
#>  1 2020-01-03    AF           Afghan~ EMRO               0                0
#>  2 2020-01-04    AF           Afghan~ EMRO               0                0
#>  3 2020-01-05    AF           Afghan~ EMRO               0                0
#>  4 2020-01-06    AF           Afghan~ EMRO               0                0
#>  5 2020-01-07    AF           Afghan~ EMRO               0                0
#>  6 2020-01-08    AF           Afghan~ EMRO               0                0
#>  7 2020-01-09    AF           Afghan~ EMRO               0                0
#>  8 2020-01-10    AF           Afghan~ EMRO               0                0
#>  9 2020-01-11    AF           Afghan~ EMRO               0                0
#> 10 2020-01-12    AF           Afghan~ EMRO               0                0
#> # ... with 68,140 more rows, and 2 more variables: new_deaths <dbl>,
#> #   cumulative_deaths <dbl>
## basic example code
```

`covid` dataset is downloaded from [WHO Coronavirus Disease
Dashboard](https://covid19.who.int/table). Every time library the
package, the package would download the latest data from the website.

## Run `covid19ViewerShiny`

After installing the package, type `launch_app()` in the console to run
the `covid19ViewerShiny` Shiny app.

## Overview of the Shiny app

<img src="man/image/shiny.png" width="100%" />
