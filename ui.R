library(shiny)
library(shinythemes)
library(rCharts)

shinyUI(
  navbarPage(
    title="Bo's Little Text Miner",
    theme=shinytheme("readable"),
    tabPanel(
      "Data",
      sidebarLayout(
        sidebarPanel(
          radioButtons(
            "data_source",
            label="Select a data source:",
            choices=list(
              "The Tragedy of Romeo and Juliet"=3,
              "Alice's Adventures in Wonderland"=2,
              "Upload my own data"=1
            ),
            selected=2
          ),
          fileInput(
            "upload_data",
            label="",
            accept=c("text/csv", "text/comma-separated-values", "text/plain", ".csv", ".txt")
          )
        ),
        mainPanel(
          htmlOutput("text_data"),
          tags$head(includeScript("www/google_analytics.js")),
          tags$head(tags$script(src="control.js")),
          tags$script("$('#upload_data').hide();", type="text/javascript")
        )
      )
    ),
    tabPanel(
      "Text Analysis",
      sidebarLayout(
        sidebarPanel(
          sliderInput("min_freq", label="Minimum word frequency", min=5, max=50, value=35, step=5),
          br(),
          textInput("c_stopwords", label="Remove following words: (separate by comma)", value="alice,said"),
          br(),
          checkboxInput("remove_preposition", label="Remove English preposition", value=TRUE),
          checkboxInput("remove_stemming", label="Remove word stemming", value=TRUE)
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Word Frequency", showOutput("word_freq", "highcharts")),
            tabPanel("Word Cloud", plotOutput("word_cloud", height="600px"))
          )
        )
      )
    ),
    tabPanel(
      "About",
      fluidPage(
        tags$a("Contact Author", href="mailto:cui.bo@bcg.com?Subject=Text Miner"),
        br(),
        tags$a("GitHub", href="http://github.bcg.com/boc/text-miner.git", target="_blank")
      )
    )
  )
)



