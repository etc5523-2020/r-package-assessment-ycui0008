#' Global covid-19 cases and deaths
#'
#' @description
#' This dataset contains covid-19 cases and deaths of 225 countries. The date of the dataset is 2020-10-06, originally.
#'
#' @format  A data frame with columns:
#' \describe{
#'  \item{date_reported}{Date of reported cases and deaths.}
#'  \item{country_code}{Unique code for countries.}
#'  \item{country}{Full country names.}
#'  \item{who_region}{Region defined by WHO.}
#'  \item{new_cases, new_deaths}{New cases/deaths in last 24 hours.}
#'  \item{cumulative_cases, cumulative_deaths}{Total number of cases and deaths.}
#' }
#'
#'
#'
#' @source
#' World Health Organisation (WHO)
#' <https://covid19.who.int/WHO-COVID-19-global-data.csv>, downloaded 2020-10-06
#'
#'
"covid"
