#' Create new map from template
#'
#' @description
#' Creates a new `grr` map from one of several template options.
#'
#' @param template Name of template. Run `list_templates()` to see current options
#' @param modules A character vector indicating modules from the template
#' to add. See options with `available_modules("template")`.
#' @param ... Additional arguments.
#' @return A S3 object of class `grr` built upon a list.
#' @export
create_from_template <- function(template, modules = "none", ...) {
    # consider re-writing to look like usethis::find_template
    if (!(template %in% list_templates())) {
        usethis::ui_stop("{ui_value(template)} is not one of the available templates.
                         Try one of {ui_value(list_templates())}.")
    }
    readr::read_rds(paste0("templates/", template, ".rda"))
}


#' List available map templates
#'
#' @description
#'
#' @return A character vector of the available templates.
#' @export
list_templates <- function() {
    data(package = "gatherer")$results[,"Item"] # Wow this is ugly
}
