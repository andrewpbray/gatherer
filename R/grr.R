#' Construct a new `grr` object
#'
#' @description
#' A constructor to create a new `grr` S3 object with a blank template.
#'
#' @param map_file A named list corresponding to the json file that's
#' readable by gather.town.
#' @param template_info A named list of information corresponding to the
#' template from which the object was created.
#' @return A S3 object of class `grr` built upon a list.
#' @export
new_grr <- function(map_file = list(), map_id = character(),
                    space_id = character(), api_key = character()) {
    out <- list(map_file = map_file, modules = list())
    attr(out$map_file, "map_id") <- map_id
    attr(out$map_file, "space_id") <- space_id
    attr(out, "title") <- ""
    attr(out, "description") <- ""
    structure(out, class = c("grr", "list"))
}


#' Construct a new `grr_mod` object
#'
#' @description
#' A constructor to create a new `grr_mod` S3 object.
#'
#' @param map_file A named list corresponding to the json file that's
#' readable by gather.town.
#' @param template_info A named list of information corresponding to the
#' template from which the object was created.
#' @return A S3 object of class `grr_mod` built upon a list.
#' @export
new_grr_mod <- function(module) {
    structure(module, class = c("grr_mod", "list"))
}

#' Plot a background map
#'
#' @description
#' Generates a raster image of the png background map.
#'
#' @param map A map object of class `grr`.
#' @export
plot.grr <- function(x, y, ...) {
    url <- x$map_file$backgroundImagePath
    img <- png::readPNG(RCurl::getURLContent(url)) # swap out for curl and make more robust
    grid::grid.newpage()
    grid::grid.raster(img)
}


#' Summary of a `grr` map
#'
#' @description
#' Prints useful summary information about a `grr` object.
#'
#' @param map A map object of class `grr`.
#' @export
summary.grr <- function(obj, ...) {
    cat(paste(paste0("Description: ", attr(obj, "description")),
           paste0("Modules: ", paste0(names(obj$modules), collapse = ", ")),
           sep = "\n"))
}




