#' Run `covid-19 Viewer` Shiny app
#'
#'
#'
#' @source
#'
#'
#'
#'
#'
#' @export
runShinyPackageApp <- function(){
  appDir <- system.file("app", package = "covid19ViewerShiny")

  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `covid19ViewerShiny`.", call. = FALSE)
  }

  shiny::runApp()
}
