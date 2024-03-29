% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gather_api.R
\name{get_map}
\alias{get_map}
\title{Get a map from gather.town}
\usage{
get_map(space_id, map_id, api_key)
}
\arguments{
\item{space_id}{A space ID, which is the string of random
characters and space name from the space's URL; the portion
of the URL that follows \verb{https://gather.town/app}.}

\item{map_id}{A map ID as a string, which is the same name as the
map file that would load at \url{https://gather.town/mapmaker}.}

\item{api_key}{An API key from gather.town, passed as a string.}
}
\value{
A named list containing all of the information that defines
the map
}
\description{
Fetches a map from gather.town and makes it
available as a named list.
}
