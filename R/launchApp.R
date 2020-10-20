#' Run `covid-19 Viewer` Shiny app
#'
#'
#'
#' @description
#'
#' @source
#'
#' @import shiny
#'
#' @example
#' runShinyPackageApp()
#'
#' @export
runShinyPackageApp <- function(){
  appDir <- system.file("app", package = "covid19ViewerShiny")
  #
  # if (appDir == "") {
  #   stop("Could not find app directory. Try re-installing `covid19ViewerShiny`.", call. = FALSE)
  # }

  shiny::runApp(appDir, display.mode = "normal")
}

