
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gatherer

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/gatherer)](https://CRAN.R-project.org/package=gatherer)
<!-- badges: end -->

The goal of gatherer is to programmatically create and edit maps on
gather.town. This package is in pre-alpha and is probably
non-functional.

## Installation

The development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("andrewpbray/gatherer")
```

## Creating a map

A good starting point for your map is one of the built-in templates. To
load the basic lab classroom template, first attach the package, then
run `create_from_template()`.

``` r
library(gatherer)
my_lab <- create_from_template(template = "lab")
```

Which creates a new map object that you can inspect, edit, and
eventually push to gather.town. You can plot the background image of the
map

``` r
plot(my_lab)
```

as well as query a summary of its properties:

``` r
summary(my_lab)
```

## Host your map on gather.town

### Step one: configure your map

The minimal information that gather.town needs to know includes the name
of the map (`map_id` and the name of the space that it belongs to.
You’ll also need to pass it your API key, which you can request when
you set up an account on [gather.town](gather.town) (this functionality
is pending). .

1.  `map_id` is
2.  `space_id`

<!-- end list -->

``` r
gather_config(map = my_lab, 
              map_id = map_id, 
              space_id = space_id, 
              api_key = api_key)
```

### Step two: push your map to gather.town

``` r
push_map(my_lab)
```

## Customize your map
