#' Run `covid-19 Viewer` Shiny app
#'
#'
#'
#' @description
#' Runs `covid-19 Viewer` Shiny app contained in the `covid19ViewerShiny` package.
#'
#'
#'
#' @import shiny
#'
#' @example launch_app()
#'
#' @export
launch_app <- function(){
  appDir <- system.file("app", package = "covid19ViewerShiny")

  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `covid19ViewerShiny`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}

