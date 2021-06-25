#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(knitr)

rmdfilenyc <- c('../12_extension_project_work_nyc.rmd')
sapply(rmdfilenyc, knit, quiet = T)
# 
# rmdfilephilly <- c("rmdfiles/11_extension_project_work_philly.Rmd")
# sapply(rmdfilephilly, knit, quiet = T)
# 
# rmdfilechicago <- c("rmdfiles/13_extension_chicago.Rmd")
# sapply(rmdfilechicago, knit, quiet = T)

# Define UI ----
ui <- navbarPage(
    "Police Complaints in different cities",
    
    tabPanel("NYC",
             includeMarkdown("12_extension_project_work_nyc.md")
    ),
    
    tabPanel("Philadelphia",
             includeMarkdown("11_extension_project_work_philly.md")
    ),
    
    tabPanel("Chicago",
             includeMarkdown("13_extension_chicago.md")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
