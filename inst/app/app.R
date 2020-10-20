library(shiny)
library(readr)
library(tidyverse)
library(plotly)
library(gridExtra)
library(shinyWidgets)
library(shinythemes)
library(leaflet)
library(leaflet.providers)
library(ggplot2)
library(covid19ViewerShiny)

# Data input
# covid <- read_csv(here::here("data/WHO-COVID-19-global-data.csv")) %>%
#     janitor::clean_names()

# scrape from website
# population <- read_html("https://www.worldometers.info/world-population/population-by-country/")
# poplation_country <- population %>%
#     html_nodes("tr :nth-child(2)") %>% html_text()
#
# pop_number <- population %>%
#     html_nodes("td:nth-child(3)") %>% html_text()
#
# pop_table <- tibble(country = poplation_country[-1], population = pop_number)

# # convert char to numbers
# pop_table$population <- as.numeric(gsub(",","", pop_table$population))
#
# pop_table <- pop_table %>%
#     mutate(population_per_100k = population/100000)
#
# pop_table <- pop_table %>%
#     mutate(country = recode(country,
#                             "United States" = "United States of America",
#                             "United Kingdom" = "The United Kingdom"))
#
# countries <- unique(covid$country)

# rename country names for map data
map <- map_data("world") %>%
    mutate(region = recode(region,
                           "USA" = "United States of America",
                           "UK" = "The United Kingdom"))


# df1 <- covid %>%
#     left_join(pop_table, by = c("country" = "country")) %>%
#     left_join(map, by = c("country" = "region"))



# Define UI
ui <- fluidPage(
    # use superhero shiny theme
    theme = shinytheme("superhero"),

    # Application title
    navbarPage("Covid-19 viewer",
               # Map tab
               tabPanel("Map", fluid = TRUE, icon = icon("globe"),
                        fluidRow(
                            column(6,
                                   sliderInput("end_date3", "Choose the End Date:",
                                               min = min(covid$date_reported),
                                               max = max(covid$date_reported),
                                               value = max(covid$date_reported))),
                            column(6,
                                   h3(p("NOTICE!"),
                                      p("This leaflet plot would take some time, please be patient.")))
                        ),
                        column(6,
                               h3(p("Global Cumulative Cases"))),

                        leafletOutput("leaflet_map_cases"),
                        column(6,
                               h3(p("Global Cumulative Deaths"))),

                        leafletOutput("leaflet_map_deaths")),
               # Table tab
               tabPanel("Table", fluid = TRUE, icon = icon("book"),
                        fluidRow(
                            column(12,
                                   h3(p("The origin dataset is not the latest dataset."),
                                      p("If USER wants the latest Covid-19 dataset. Please download the latest WHO Coronavirus Desease Data from ",
                                        a("WHO website",href = "https://covid19.who.int/WHO-COVID-19-global-data.csv"),
                                        " and put it into data folder.")))),
                        # select countries
                        pickerInput("country_select1", "Country:",
                                    choices = unique(covid$country),
                                    options = list(`actions-box` = TRUE, `none-selected-text` = "Please make a selection!"),
                                    selected = unique(covid$country)[1:10],
                                    multiple = TRUE),
                        dataTableOutput("table1")),
               tabPanel("Graphs", fluid = TRUE, icon = icon("chart-bar"),
                        # select end date
                        fluidRow(
                            column(6,
                                   sliderInput("end_date2", "Choose the End Date:",
                                               min = min(covid$date_reported),
                                               max = max(covid$date_reported),
                                               value = max(covid$date_reported)),
                                   # select countries
                                   pickerInput("country_select2", "Country:",
                                               choices = unique(covid$country),
                                               options = list(`actions-box` = TRUE, `none-selected-text` = "Please make a selection!"),
                                               selected = unique(covid$country)[1:10],
                                               multiple = TRUE)),

                            column(6,
                                   h4(p("Column plot shows the latest cumulative_cases and cumulative_deaths of selected countries."),
                                      p("Line plot tells user the new_cases and new_deaths of selected countries. Solid lines represent the new_cases, and the dashed lines represent the new_deaths.")))
                        ),
                        plotOutput("colplot"),
                        plotlyOutput("lineplot")),
               # About page
               tabPanel("About", fluid = TRUE, icon = icon("book-open"),
                        fluidRow(
                            column(6,
                                   h4(p("About this App")),
                                      h5(p("This App is used to monitor global covid-19 cases and deaths, and it can compare the covid-19 cases in different countries."))),
                            column(6,
                                   h4(p("About Creator of this App")),
                                   h5(p("Yuheng Cui is a student in Monash Uni. He completed Bachelor degree in Monash Uni as well. He studied Bachelor of Accounting, but he thought IT-related skills are very important for his future career, so he chose to study Master of BA."),
                                      p(a("source code in GitHub", href = 'https://github.com/etc5523-2020/shiny-assessment-ycui0008'), "and", a("Yuheng's blog", href = 'https://ycui0008-blog.netlify.app/')))),
                            br(),
                            # Acknowledgments
                            column(12,
                                   h4(p("Acknowledgments")),
                                   h5(p("This shiny App uses following packages:"),
                                      p("shiny, readr, tidyverse, plotly, gridExtra, and shinyWidgets")),
                                      br(),
                                   # References
                                   h4(p("References")),
                                   h5(p("C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC Florida, 2020."),
                                      p("Baptiste Auguie (2017). gridExtra: Miscellaneous Functions for \"Grid\" Graphics. R package version 2.3. https://CRAN.R-project.org/package=gridExtra"),
                                      p("Hadley Wickham, Jim Hester and Romain Francois (2018). readr: Read Rectangular Text Data. R package version 1.3.1. https://CRAN.R-project.org/package=readr"),
                                      p(" Victor Perrier, Fanny Meyer and David Granjon (2020). shinyWidgets: Custom Inputs Widgets for Shiny. R package version 0.5.4. https://CRAN.R-project.org/package=shinyWidgets"),
                                      p("Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686"),p("Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny")))
                        ))
))

# Define server logic required to draw a histogram
server <- function(input, output) {

    #col plot
    output$colplot <- renderPlot({
        # generate bins based on input$bins from ui.R
        end_date <- input$end_date

        # cumulative deaths col plot
        p1 <- covid %>%
            filter(date_reported == input$end_date2 & country %in% input$country_select1) %>%
            arrange(-cumulative_deaths) %>%
            head(5) %>%
            ggplot(aes(x = reorder(country, cumulative_deaths), y = cumulative_deaths)) +
            geom_col(fill = 'red') +
            ggtitle("Cumulative deaths") +
            coord_flip()

        # cumulative cases col plot
        p2 <- covid %>%
            filter(date_reported == input$end_date2 & country %in% input$country_select1) %>%
            arrange(-cumulative_cases) %>%
            head(5) %>%
            ggplot(aes(x = reorder(country, cumulative_cases), y = cumulative_cases)) +
            geom_col(fill = 'blue') +
            ggtitle("Cumulative cases")+
            coord_flip()

        # combine them together
        grid.arrange(p1,p2, ncol = 2)})

    # Data table
    output$table1 <- renderDataTable({
        covid %>%
            select(-country_code, -who_region) %>%
            filter(country %in% input$country_select1 &
                       date_reported == max(covid$date_reported)) %>%
            rename(date = date_reported)
        })

    # plotly line plot
    output$lineplot <- renderPlotly({
        p1 <- covid %>%
            pivot_longer(cols = c("new_cases","cumulative_cases", "new_deaths", "cumulative_deaths"), names_to = "type", values_to = "cases") %>%
            mutate(cases = as.numeric(cases)) %>%
            filter(type %in% c("new_cases", "new_deaths")) %>%
            filter(country %in% input$country_select2 &
                       date_reported <= input$end_date2) %>%
            ggplot(aes(x = date_reported, y = cases, group = type, linetype = type, color = country)) +
            geom_line() +
            theme(legend.title = element_blank()) +
            scale_x_date(date_breaks = "1 month") +
            theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
            xlab("Date reported")

        ggplotly(p1)
    })

    # df2 <- reactive({
    #     df1 <- covid %>%
    #         left_join(pop_table, by = c("country" = "country")) %>%
    #         left_join(map, by = c("country" = "region")) %>%
    #         filter(date_reported == input$end_date3)
    #
    #     # df2 <- filter(df1, date_reported == input$end_date3)
    #
    #     df3 <- df1 %>%
    #         group_by(country) %>%
    #         summarise(long_mean = mean(long),
    #                   lat_mean = mean(lat))
    #
    #     df1 %>%
    #         left_join(df3, by = c("country" = "country"))
    # })

    output$leaflet_map_cases <- renderLeaflet({
        df1 <- covid %>%
            # left_join(pop_table, by = c("country" = "country")) %>%
            left_join(map, by = c("country" = "region")) %>%
            filter(date_reported == input$end_date3)

        # df2 <- filter(df1, date_reported == input$end_date3)

        df3 <- df1 %>%
            group_by(country) %>%
            summarise(long_mean = mean(long),
                      lat_mean = mean(lat))

        df2 <- df1 %>%
            left_join(df3, by = c("country" = "country"))

        leaflet(df2) %>% addTiles() %>%  # Add default OpenStreetMap map tiles
            addProviderTiles(providers$CartoDB.Positron) %>%
            addCircleMarkers(lat = ~lat_mean, lng = ~long_mean, weight = 1, radius = ~(cumulative_cases)^0.2,
                             fillOpacity = 0.009, group = "cumulative_cases")
    })

    output$leaflet_map_deaths <- renderLeaflet({
        df1 <- covid %>%
            # left_join(pop_table, by = c("country" = "country")) %>%
            left_join(map, by = c("country" = "region")) %>%
            filter(date_reported == input$end_date3)

        # df2 <- filter(df1, date_reported == input$end_date3)

        df3 <- df1 %>%
            group_by(country) %>%
            summarise(long_mean = mean(long),
                      lat_mean = mean(lat))

        df2 <- df1 %>%
            left_join(df3, by = c("country" = "country"))

        leaflet(df2) %>% addTiles() %>%  # Add default OpenStreetMap map tiles
            addProviderTiles(providers$CartoDB.Positron) %>%
            addCircleMarkers(lat = ~lat_mean, lng = ~long_mean, weight = 1, radius = ~(cumulative_deaths)^0.2,
                             fillOpacity = 0.009, color = "red", fillColor = "red", group = "cumulative_deaths")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
