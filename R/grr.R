#' Construct a new `grr` object
#'
#' @description
#' A constructor to create a new `grr` S3 object.
#'
#' @param map_file A named list corresponding to the json file that's
#' readable by gather.town.
#' @param template_info A named list of information corresponding to the
#' template from which the object was created.
#' @return A S3 object of class `grr` built upon a list.
#' @export
new_gatherer <- function(map_file = list(), map_id = character(),
                         space_id = character(), api_key = character()) {
    out <- list(map_file = map_file,
                template = list(name = character(),
                                description = character(),
                                available_modules = list()),
                gather_config = list(map_id = map_id,
                                     space_id = space_id,
                                     api_key = api_key))

    structure(out, class = c("grr", "list"))
}

#' Plot a background map
#'
#' @description
#' Generates a raster image of the png background map.
#'
#' @param map A map object of class `grr`
#' @export
plot.grr <- function(x, y, ...) {
    url <- x$map_file$backgroundImagePath
    img <- png::readPNG(RCurl::getURLContent(url)) # swap out for curl and make more robust
    grid::grid.newpage()
    grid::grid.raster(img)
}




# str.gatherer <- function(object, ...) {
#     n <- length(object)
#     cat(paste0(class(object)[1], " of length ", n))
#     if (n > 0) {
#         cat("; first list element: ")
#         str(object[[1]], ...)
#     }
# }
