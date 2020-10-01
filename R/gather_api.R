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
#'
#'
# Todo:
# - Separate out the api-access portion with tests
# - Allow for extraction of full request
# - Return an object of class `gather` to allow for a print method
#     and various extractors

get_map <- function(api_key, space_id, map_id) {
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
#' @param api_key An API key from gather.town, passed as a string.
#' @param space_id A space ID, which is the string of random
#' characters and space name from of your space's URL; the portion in
#' of the URL that follows `https://gather.town/app`.
#' @param map_id A map ID as a string, which is the same name as the
#' map file that would load at [https://gather.town/mapmaker](https://gather.town/mapmaker).
#' @param map_file The map file, as named list.
#' @export
#' Todo: create a second non-api-package  function that this only a
#' function of map_file that collects other fields from that object.

post_map <- function(api_key, space_id, map_id, map_file, ...) {
    url <- modify_url("https://gather.town/api/setMap")
    POST(url,
         body = list(apiKey     = api_key,
                     spaceId    = space_id,
                     mapId      = map_id,
                     mapContent = map_file),
         encode = "json",
         ...)
}

# Helper functions around API

#' Pull a map from gather.town
#'
#' @description
#' Pulls a map from gather.town.
#'
#' @param map An object of class `"gatherer"`.
#' @return An object of class `"gatherer"` from the gather.town server
#' @details Though "pull" may bring to mind git, this function does
#' not interface with git.
#' @export

pull_map <- function(map) {
    get_map(api_key  = map$api_key,
            space_id = map$api_key,
            map_id   = map$map_id)
}

#' Push a map to gather.town
#'
#' @description
#' Pushes a map file from R and posts it on gather.town.
#'
#' @param map An object of class `"gatherer"`.
#' @export

push_map <- function(map) {
    post_map(api_key  = map$api_key,
             space_id = map$space_id,
             map_id   = map$map_id,
             map_file = map$map_file)
}
