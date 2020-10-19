#' Load `grr` object from a template
#'
#' @description
#' Loads a new `grr` map from one of several template options.
#'
#' @param template Name of template. Run `list_templates()` to see current options
#' @param modules A character vector indicating modules from the template
#' to add. See options with `available_modules("template")`.
#' @param ... Additional arguments.
#' @return A S3 object of class `grr` built upon a list.
#' @export
load_grr <- function(template, modules = "none", ...) {
    path <- find_template(template)
    readr::read_rds(path)
}

find_template <- function(template, package = "gatherer") {
    path <- tryCatch(
        fs::path_package(package, "templates", paste0(template, ".Rda")),
        error = function(e) ""
    )
    if (identical(path, "")) {
        usethis::ui_stop("Could not find {usethis::ui_value(template)}. \\
                         Try one of: {usethis::ui_value(list_templates())}."
                         )
    }
    path
}

#' List available map templates
#'
#' @description
#'
#' @return A character vector of the available templates.
#' @export
list_templates <- function(package = "gatherer") {
    fs::path_package(package, "templates") %>%
        fs::dir_ls() %>%
        fs::path_file() %>%
        fs::path_ext_remove()

}


#' Create modules for a template
#'
#' @description
#' Creates a list of `grr_mod` modules, each containing at least one
#' `grr_obj`.
#'
#' @param ... One or more modules as lists, each separated by a comma.
#' @return A S3 object of class `grr_mod` built upon a list.
#' @export
create_template <- function(obj, title, description, ...) {
    if (!missing(...)) {
        # transfer objects from map_file to template
        obj$modules <- fill_template(obj, ...)
        obj$map_file$objects <- list()
    }
    attr(obj, "title") <- title
    attr(obj, "description") <- description
    obj
}

fill_template <- function(obj, ...) {
    names(obj$map_file$objects) <- names(sort(c(...))) # label objects
    obj$modules <- link_objs_to_mods(obj)
}

link_objs_to_mods <- function(obj) {
    mod_names <- gsub("_\\d*$", "", names(obj$map_file$objects))
    modules <- unique(mod_names) %>%
        purrr::map(objs_to_mod, mod_names, obj$map_file$objects)
    names(modules) <- unique(mod_names)
    modules
}

objs_to_mod <- function(u, mod_names, map_objs) {
    new_grr_mod(map_objs[mod_names == u])
}
#write_grr_template()
