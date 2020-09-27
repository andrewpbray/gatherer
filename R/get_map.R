#' Get a map from gather.town
#'
#' @description
#' This function fetches your map from gather.town's API and makes it
#' available as a named list.
#'
#' @param api_key Your API key from gather.town, passed as a string.
#' @param space_id Your space ID, which is the string of random
#' characters and space name from of your space's URL; the portion in
#' of the URL that follows `https://gather.town/app`.
#' @param map_id Your map ID as a string, which is the same name as the
#' map file that you would load at [https://gather.town/mapmaker](https://gather.town/mapmaker).
#' @return A named list containing all of the information that defines
#' the map
#' @export
#'
#'
# This should be refactored separate out the api-access portion with tests
# And to make the raw json file available.
get_map <- function(api_key, space_id, map_id) {
    url <- httr::modify_url("https://gather.town/api/getMap",
                            query = list(apiKey = api_key,
                                         spaceId = I(space_id),
                                         mapId   = map_id))
    resp <- httr::GET(url, accept_json())
    jsonlite::fromJSON(content(resp, "text"),
                       simplifyVector = FALSE)
}
