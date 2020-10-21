#' Create a multiSelection drop list
#'
#' @description
#' This function can help user to create a drop list.
#'
#' @param id id name of the input, it must be a character
#' @param inputDisplay The name of the selection drop list
#' @param selection A list of character.
#'
#' @import shinyWidgets
#'
#'
#' @examples
#' multiSelection("country_select1", "Country:", covid$country)
#'
#' @export
multiSelection <- function(id, inputDisplay, selection){
  # id must be char type
  # inputDisplay must be char followed by a ":"
  # selection must be vector

  shinyWidgets::pickerInput(id, inputDisplay,
              choices = unique(selection),
              options = list(`actions-box` = TRUE, `none-selected-text` = "Please make a selection!"),
              selected = unique(selection)[1:10],
              multiple = TRUE)

}
