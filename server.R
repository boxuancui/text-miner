library(shiny)
library(data.table)
library(tm)
library(wordcloud)
library(ggplot2)


shinyServer(function(input, output) {
  freqData <- reactive({
    minFreq <- input$min_freq
    tt <- findFreqTerms(tdm, minFreq)
    termFrequency <- rowSums(as.matrix(tdm[tt, ]))
    wordFreqs <- data.table(word=names(termFrequency), frequency=termFrequency)
    wordFreqs <- wordFreqs[order(-rank(frequency))]
    wordFreqs
  })
  
  output$freqChart <- renderPlot({
    wordFreqs <- freqData()
    ggplot(wordFreqs, aes(x=word, y=frequency)) +
      geom_bar(stat="identity") +
      coord_flip()
  }, width=1024)
  
  output$wordCloud <- renderPlot({
    wordFreqs <- freqData()
    wordcloud(wordFreqs$word, wordFreqs$frequency, scale=c(8, 0.3), min.freq=20, random.order=FALSE, rot.per=0.15, colors=brewer.pal(8, "Dark2"))
  }, width=1024)
  
})

