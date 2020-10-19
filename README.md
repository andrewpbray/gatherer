
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
my_commons <- load_grr(template = "commons")
```

Which creates a new map object that you can inspect, edit, and
eventually push to gather.town. You can plot the background image of the
map

``` r
plot(my_commons)
```

as well as query a summary of its properties:

``` r
summary(my_commons)
```

## Customize your map

Beyond the basic video chat functionality of your new map, you can embed
more functionality by adding modules. The result of `summary(my_lab)`
showed that this template has a module called `videos`. Go ahead and add
it.

``` r
my_commons <- activate_videos(my_commons)
```

All modules start with default settings, but it’s often useful to
customize them for your own purpose. This template has two embedded
video objects, so express your love of animals by adding in two embedded
video links from YouTube.

``` r
eating   <- "https://www.youtube.com/embed/pZ0XvDsgN3A"
sleeping <- "https://youtu.be/pp0_tMnf0Eg"
my_commons <- edit_vidoes(my_classroom, url = list(video_1 = eating,
                                                   video_2 = sleeping))
```

## Host your map on gather.town

### Step one: configure your map

The minimal information that gather.town needs to know includes the name
of the map (`map_id`) and the name of the space that it belongs to
(`space_id`). You’ll also need to pass it your API key, which you can
request when you set up an account on [gather.town](gather.town) (this
functionality is pending). .

1.  `map_id` should be
2.  `space_id`

<!-- end list -->

``` r
my_commons <- config_gather(map = my_commons,
                            map_id = map_id, 
                            space_id = space_id, 
                            api_key = api_key)
```

### Step two: push your map to gather.town

``` r
push_map(my_commons)
```

In one pipe:

``` r
load_grr(template = "commons") %>%
  activate_videos() %>%
  edit_vidoes(url = list(video_1 = "https://www.youtube.com/embed/pZ0XvDsgN3A",
                         video_2 = "https://youtu.be/pp0_tMnf0Eg")) %>%
  config_gather(map_id = map_id, 
                space_id = space_id) %>%
  push_map(api_key = api_key)
```
