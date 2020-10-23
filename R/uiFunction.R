globalVariables("covid$country")
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
multiSelection <- function(id, inputDisplay = " ", selection = covid$country){
  # id must be char type
  if (is.null(id)||is.null(inputDisplay) || is.null(selection))
    stop("argument must not be null.")

  if (nchar(id)==0)
    stop("length of id must not be zero.")

  # id and inputDisplay must be character
  if (!is.character(id) )
    stop("id must be character.")

  if (!is.character(inputDisplay))
    stop("inputDisplay must be character.")

  # selection must be vector
  if (!is.vector(selection))
    stop("selection must be vector.")


  shinyWidgets::pickerInput(id, inputDisplay,
              choices = unique(selection),
              options = list(`actions-box` = TRUE, `none-selected-text` = "Please make a selection!"),
              selected = unique(selection)[1:10],
              multiple = TRUE)

}
