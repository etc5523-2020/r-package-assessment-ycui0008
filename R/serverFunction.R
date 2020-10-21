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
#' @param varName Variable name. The variable name must be within the dataset --- `data`.
#' @param title Title of the col plot.
#'
#'
#' @import ggplot2
#' @importFrom stats reorder
#' @importFrom stats filter
#' @importFrom utils head
#'
#' @examples
#' colPlot(data = covid, date = input$end_date2, color = 'red', varName = cumulative_deaths, title = "Cumulative deaths")
#'
#' @export
colPlot <- function(data, date, color, varName, title){
  data %>%
    filter(date_reported == {{date}}) %>%
    arrange(desc({{varName}})) %>%
    head(5) %>%
    ggplot2::ggplot(aes(x = reorder(country, {{varName}}), y = {{varName}})) +
    geom_col(fill = color) + #color must be character
    ggplot2::ggtitle(title) + # as well as title
    coord_flip()
}
