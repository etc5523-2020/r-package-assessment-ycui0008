#' colPlot function
#'
#' @description
#' This function is used to create column plot.
#'
#'
#'
#' @param data Input dataset.
#' @param date End date.
#' @param color Color of the columns in the plot.
#' @param varName Variable name. Recommend user enter either `cumulative_cases` or `cumulative_deaths` here.
#' @param title Optional. Title of the col plot.
#'
#'
#' @import ggplot2
#' @importFrom stats reorder
#' @importFrom dplyr filter
#' @importFrom utils head
#'
#'
#' @export
colPlot <- function(data = covid, date = input$end_date2, color = 'red', varName, title){

  if (ncol(data) != ncol(covid))
    stop("Please enter valid data name")



  data %>%
    dplyr::filter(date_reported == {{date}}) %>%
    dplyr::arrange(desc({{varName}})) %>%
    utils::head(5) %>%
    ggplot2::ggplot(aes(x = reorder(country, {{varName}}), y = {{varName}})) +
    geom_col(fill = color) + #color must be character
    ggplot2::ggtitle(title) + # as well as title
    coord_flip()
}

