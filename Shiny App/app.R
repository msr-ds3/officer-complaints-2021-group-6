#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(knitr)

# rmdfilenyc <- c('rmdfiles/12_extension_project_work_nyc.Rmd')
# sapply(rmdfilenyc, knit, quiet = T)
# # #
# # rmdfilephilly <- c("rmdfiles/11_extension_project_work_philly.Rmd")
# # sapply(rmdfilephilly, knit, quiet = T)
# # #
# # rmdfilechicago <- c("rmdfiles/13_extension_chicago.Rmd")
# # sapply(rmdfilechicago, knit, quiet = T)

# Define UI ----
ui <- navbarPage(
    "Police Complaints in different cities",
    
    tabPanel("NYC",
             includeHTML("html/nyc.nb.html")
    ),
    
    tabPanel("Philadelphia",
             includeHTML("html/philly.nb.html")
    ),
    
    tabPanel("Chicago",
             includeHTML("html/chicago.nb.html")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
