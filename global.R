#################
#### load library
#################
library(shiny)
library(data.table)
library(tm)
library(SnowballC)

alice_story <- paste(readLines("data/story.txt"), collapse="<br/>")

# load("data/tdm.RData")
# raw <- fread("data/raw_data.csv", header=TRUE, sep=",")
# cleaned <- raw[!is.na(notes) & notes!=""]
# 
# data_text <- cleaned$notes
# corpus <- Corpus(VectorSource(data_text))
# corpus <- tm_map(corpus, tolower)
# corpus <- tm_map(corpus, stripWhitespace)
# corpus <- tm_map(corpus, removePunctuation)
# my_stopwords <- c(stopwords("english"), c("dont", "didnt", "arent", "cant", "one", "two", "three"))
# corpus <- tm_map(corpus, removeWords, my_stopwords)
# corpus <- tm_map(corpus, stemDocument, language="english")
# corpus <- tm_map(corpus, PlainTextDocument)
# tdm <- TermDocumentMatrix(corpus)
# save(tdm, file="data/tdm.RData")

