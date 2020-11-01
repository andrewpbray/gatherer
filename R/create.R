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


#' Create template map
#'
#' @description
#' Takes a map file from gather and annotates it so that it can serve as a
#' template file.
#'
#' @param obj A barebones `grr` map object created by `fetch_map()`.
#' @param title Title of the new template, as a string.
#' @param description 1-3 sentence description of the template as a string.
#' @param ... The names and order of any objects in the map file, passed as
#' named integers separated by commas. See details.
#' @return A S3 object of class `grr_mod` built upon a list.
#' @details This function serves to provide meta-data on the template  through
#' the `title` and `description` and to name any objects through the `...`.
#' For example,
#' if the map file has two objects that are both videos, you could pass in:
#' `"videos_1" = 1, "videos_2" = 2`. This will label the first two
#' objects `"videos_1"` and `"videos_2"` and group them as a module called
#' `"videos"`.
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
    names(obj$map_file$objects) <- names(sort(c(...))) # label objects in map file
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
