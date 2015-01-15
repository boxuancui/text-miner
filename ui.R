library(shiny)

shinyUI(
  fluidPage(
    h3("Bo's Little Text Miner"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("min_freq", label="Minimum Frequency", min=50, max=1000, value=250, step=50)
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Frequency Chart", plotOutput("freqChart", height="900px")),
          tabPanel("Word Cloud", plotOutput("wordCloud", height="768px"))
        )
      )
    )
  )
)