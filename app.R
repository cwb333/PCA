require(shiny)
require(dplyr)
require(tools)
require(DBI)
require(DT)
require(shinyjs)
require(utils)
require(httr)
require(reshape2)
require(data.table)
require(FactoMineR)
require(factoextra)

source("pCa_group.R")
source("pCa_ind.R")

ui <- shinyUI(
  fluidPage(
    theme = "bootstrap.css",
    title = "",
    windowTitle = "Statistics Gateway",
    navbarPage(
      position = 'static-top',
      img(
        src = "acacia edited.svg",
        height = "100px",
        width = "280px",
        style = " margin-left: 25px;
                             margin-right: 160px; margin-top: -5px;"
      ),
      tabPanel(
        h3("PCA Gateway"),
        sidebarLayout(
          sidebarPanel(
            style = "background-color: #262b2e; color: #ffffff",
            tags$head(tags$style(
              ".progress-bar{background-color:#660000;}"
            )),
            tags$head(tags$style(".btn{background-color:#660000;}")),
            tags$head(tags$style(
              ".btn:hover{background-color:#34000d;}"
            )),
            titlePanel("PCA Groups"),
            fileInput(
              "newfile1",
              "Upload Data",
              accept = c(
                "text/csv",
                "text/comma-separated-values",
                "text/tab-separated-values",
                "text/plain",
                ".xlsx",
                ".csv",
                ".tsv"
              )
            ),
            downloadButton('download1', 'Save PCA Groups'),
            tags$head(
              tags$style(
                ".predictNew{background-color:#660000;}
                 .predictNew{color: white;}
                 .predictNew{border: none;}
                 .predictNew:hover{background-color: #34000d;}"
              )
            )
          ),
          mainPanel(plotOutput("pca_group"))
        ),
        sidebarLayout(
          sidebarPanel(
            style = "background-color: #262b2e; color: #ffffff",
            tags$head(tags$style(
              ".progress-bar{background-color:#660000;}"
            )),
            tags$head(tags$style(".btn{background-color:#660000;}")),
            tags$head(tags$style(
              ".btn:hover{background-color:#34000d;}"
            )),
            titlePanel("PCA Individuals"),
            downloadButton('download2', 'Save PCA Individuals'),
            tags$head(
              tags$style(
                ".predictNew{background-color:#660000;}
                 .predictNew{color: white;}
                 .predictNew{border: none;}
                 .predictNew:hover{background-color: #34000d;}"
              )
            )
          ),
          mainPanel(plotOutput("pca_ind"))
        )
      )
    )
  )
)

server <- shinyServer(function(input, output, session) {
  newPCA_group <- reactive({
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    startTime <- format(Sys.time(), '%b-%d, %I:%M')
    
    temp <- tempdir()
    
    if (is.null(input$newfile1)) {
      return(NULL)
    }
    initData1 <-
      read.csv(input$newfile1$datapath,
               header = T)
    
    pCa_group(initData1)
    
  })
  
  output$pca_group <- renderPlot(newPCA_group())
  
  output$download1 <- downloadHandler(
    filename = function() {
      paste0("PCA Groups",  " ", input$newfile1, '/', 'PCA groups.pdf')
    },
    content = function(file) {
      pdf(file)
      plot(newPCA_group())
      dev.off()
    }
  )
  
  
  newPCA_ind <- reactive({
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    startTime <- format(Sys.time(), '%b-%d, %I:%M')
    
    temp <- tempdir()
    
    if (is.null(input$newfile1)) {
      return(NULL)
    }
    
    initData1 <-
      read.csv(input$newfile1$datapath,
               header = T)
    
    pCa_ind(initData1)
    
  })
  
  output$pca_ind <- renderPlot(newPCA_ind())
  
  
  output$download2 <- downloadHandler(
    filename = function() {
      paste0("PCA Individuals",
             " ",
             input$newfile1,
             '/',
             'PCA individuals.pdf')
    },
    content = function(file) {
      pdf(file)
      plot(newPCA_ind())
      dev.off()
    }
  )
  
})

shinyApp(ui, server)
