#' Construct a new `gatherer` object
#'
#' @description
#' A constructor to create a new `gatherer` S3 object.
#'
#' @param map_file A named list corresponding to the json file that's
#' readable by gather.town.
#' @param template_info A named list of information corresponding to the
#' template from which the object was created.
#' @return A S3 object of class `gatherer` built upon a list.
#' @export
new_gatherer <- function(map_file = list(), map_id = character(),
                         space_id = character(), api_key = character()) {
    out <- list(map_file = map_file,
                map_info = list(map_id = map_id,
                                space_id = space_id),
                template_info = list(),
                api_key = api_key)

    structure(out, class = c("gatherer", "list"))
}

#' Plot a `gatherer` background map
#'
#' @description
#' Generates a raster image of the png background map.
#'
#' @param map A map object of class `gatherer`
#' @export
plot.gatherer <- function(x, y, ...) {
    url <- x$map_file$backgroundImagePath
    img <- readPNG(RCurl::getURLContent(url)) # can this be swapped out for curl?
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
