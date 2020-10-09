#' Get a map from gather.town
#'
#' @description
#' Fetches a map from gather.town and makes it
#' available as a named list.
#'
#' @param api_key An API key from gather.town, passed as a string.
#' @param space_id A space ID, which is the string of random
#' characters and space name from the space's URL; the portion
#' of the URL that follows `https://gather.town/app`.
#' @param map_id A map ID as a string, which is the same name as the
#' map file that would load at [https://gather.town/mapmaker](https://gather.town/mapmaker).
#' @return A named list containing all of the information that defines
#' the map
#' @export
get_map <- function(space_id, map_id, api_key) {
    url <- httr::modify_url("https://gather.town/api/getMap",
                            query = list(apiKey = api_key,
                                         spaceId = I(space_id),
                                         mapId   = map_id))
    resp <- httr::GET(url, httr::accept_json())
    jsonlite::fromJSON(httr::content(resp, "text"),
                       simplifyVector = FALSE)
}


#' Post a map on gather.town
#'
#' @description
#' Pushes a map file from R and posts it on gather.town.
#'
#' @param map_file The map file, as named list.
#' @param space_id A space ID, which is the string of random
#' characters and space name from of your space's URL; the portion in
#' of the URL that follows `https://gather.town/app`.
#' @param map_id A map ID as a string, which is the same name as the
#' map file that would load at [https://gather.town/mapmaker](https://gather.town/mapmaker).
#' @param api_key An API key from gather.town, passed as a string.
#' @export
post_map <- function(map_file, space_id, map_id, api_key, ...) {
    url <- httr::modify_url("https://gather.town/api/setMap")
    httr::POST(url,
         body = list(apiKey     = api_key,
                     spaceId    = space_id,
                     mapId      = map_id,
                     mapContent = map_file),
         encode = "json",
         ...)
}

# Helper functions around API

#' Fetch a map from gather.town
#'
#' @description
#' Fetches a new map from gather.town and makes it
#' available as a `grr` object.
#'
#' @param api_key An API key from gather.town, passed as a string.
#' @param space_id A space ID, which is the string of random
#' characters and space name from the space's URL; the portion
#' of the URL that follows `https://gather.town/app`.
#' @param map_id A map ID as a string, which is the same name as the
#' map file that would load at [https://gather.town/mapmaker](https://gather.town/mapmaker).
#' @return A named list containing all of the information that defines
#' the map
fetch_map <- function(space_id, map_id, api_key) {
    map_file <- get_map(space_id, map_id, api_key)
    new_gatherer(map_file = map_file, space_id = space_id,
                 map_id = map_id, api_key = api_key)
}

#' Pull the map file from gather.town
#'
#' @description
#' Pulls the map file from gather.town and merges it into the map
#' object that is passed to the function.
#'
#' @param map An object of class `"grr"`.
#' @return An updated object of class `"grr"`
#' @export
pull_map <- function(map) {
    new_map_file <- get_map(api_key = map$api_key,
                            space_id = map$map_info$space_id,
                            map_id = map$map_info$map_id)
    map$map_file <- new_map_file
    map
}

#' Push a map to gather.town
#'
#' @description
#' Pushes a map file from R and posts it on gather.town.
#'
#' @param map An object of class `"grr"`.
#' @export
push_map <- function(map) {
    post_map(map_file = map$map_file,
             space_id = map$map_info$space_id,
             map_id   = map$map_info$map_id,
             api_key  = map$api_key)
}

