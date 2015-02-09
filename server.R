library(shiny)
library(data.table)
library(rCharts)
library(tm)
library(wordcloud)
library(SnowballC)


shinyServer(function(input, output, session) {
  ## data source tab
  data_handler <- reactive({
    if (input$data_source==1) {
      alice_story
    } else {
      if (is.null(input$upload_data)) return(NULL)
      paste(readLines(input$upload_data$datapath), collapse="<br/>")
    }
  })
  
  output$text_data <- renderUI({
    HTML(data_handler())
  })
  
  ## word frequency tab
  freq_data <- reactive({
    min_freq <- input$min_freq
    custom_stopwords <- unlist(strsplit(input$c_stopwords, ","))
    remove_preposition <- input$remove_preposition
    remove_stemming <- input$remove_stemming
    data_text <- gsub("<br/>", "", data_handler())
    
    corpus <- Corpus(VectorSource(data_text))
    corpus <- tm_map(corpus, tolower)
    corpus <- tm_map(corpus, stripWhitespace)
    corpus <- tm_map(corpus, removePunctuation)
    if (remove_preposition) {
      stopwords <- c(stopwords("english"), custom_stopwords)
    } else {
      stopwords <- custom_stopwords
    }
    corpus <- tm_map(corpus, removeWords, stopwords)
    if (remove_stemming) {
      corpus <- tm_map(corpus, stemDocument, language="english")
    }
    corpus <- tm_map(corpus, PlainTextDocument)
    tdm <- TermDocumentMatrix(corpus)
    tt <- findFreqTerms(tdm, min_freq)
    term_frequency <- rowSums(as.matrix(tdm[tt, ]))
    output <- data.table(word=names(term_frequency), frequency=term_frequency)
    output <- output[order(-rank(frequency))]
    output
  })
  
  output$word_freq <- renderChart2({
    data <- data.frame(freq_data())
    rownames(data) <- data$word
    data$word <- NULL
    
    a <- Highcharts$new()
    a$chart(height=600, width=800, type="bar", zoomType="xy")
    a$title(text="Drag mouse to zoom")
    a$xAxis(categories=rownames(data))
    a$legend(enabled=FALSE)
    a$data(data, dataLabels=list(enabled=FALSE))
    a
  })
  
  output$word_cloud <- renderPlot({
    min_freq <- input$min_freq
    data <- freq_data()
    
    wordcloud(data$word, data$frequency, scale=c(7, 0.2), min.freq=min_freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
  }, width=800)
})

