#################
#### load library
#################
library(shiny)
library(data.table)
library(tm)
library(SnowballC)

alice_story <- paste(readLines("data/story.txt"), collapse="<br/>")
romeo_juliet <- paste(readLines("data/romeo_juliet.txt"), collapse="<br/>")
