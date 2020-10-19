#
#
# # Extractors
#
# grr_map_file <- function(obj) {
#     obj$map_file
# }
#
# extract_grr_object <- function(x) {
#     x[is(x, "grr_object")]
# }
#
# grr_objects <- function(obj) {
#     if (purrr::vec_depth(obj) == 1) {
#         ind <- map_lgl(obj, is, class2 = "grr_object")
#         out <- obj[ind]
#     } else {
#         out <- map(obj, grr_objects)
#     }
# out
# }
#
# a <- grr_objects(v)
#
# v <- commons$template$modules$videos
# v[[1]] <- unclass(v[[1]])
# ind <- map_lgl(v, is, class2 = "grr_object")
# v[ind]
#
# grr_description <- function(obj) {
#     obj$template$description
# }
#
get_modules <- function(obj) {
    obj$template$modules
}


gather_mod <- function(x, l = list()) {
    l == x
}

#
# grr_active_modules <- function(obj) {
#
# }
#
# grr_available_modules <- function(obj) {
#     grr_modules(obj)
# }
#
#
# # Other
#
# synch_map_file <- function(obj) {
#     grr_objects(grr_map_file(obj)) <- grr_objects(grr_template(obj))
# }
