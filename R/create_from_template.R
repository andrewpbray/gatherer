#' Create new `gatherer` map from template
#'
#' @description
#'
#'
#' @param template Name of template. Run `list_templates` to see current options
#' @param remove_modules A character vector indicating modules from the template
#' that will be removed. See template documentation with `vignette("template")`
#' for options.
#' @param ... Additional arguments passed to
#' @return A S3 object of class `gatherer` built upon a list.
#' @export
create_from_template <- function(template, remove_modules = "", ...) {
    # load object
    map <- data(paste0(get(template)))
    # add class from template
    map <- structure(map, class = template)
    # remove modules
    # configure based on passed args
}
