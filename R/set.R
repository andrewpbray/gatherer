set_url <- function(obj, ...) {
    urls <- list(...)
    purrr::map(urls, ~set_url2(obj, url = .x))
}

set_url2 <- function(obj, url) {
    if (url %in% names(map_objs(obj))) {
        obj$map_file$objects$url
    } else if (url %in% names(template_objs(obj))) {
        # copy obj from template to map

        #
    } else {

    }

}
