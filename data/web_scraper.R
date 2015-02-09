library(rvest)

index.page <- html("https://www.cs.cmu.edu/~rgs/alice-table.html")
chapter.link <- index.page %>% html_node("pre") %>% html_nodes("a") %>% html_attr("href")
sink(file="story.txt", append=TRUE)

root.page <- html_session("https://www.cs.cmu.edu/~rgs/alice-table.html")
for (pg in chapter.link) {
  page <- root.page %>% jump_to(pg)
  content <- page %>% html_node("body") %>% html_text()
  links <- page %>% html_nodes("a") %>% html_text()
  for (i in links) {
    content <- gsub(i, "", content)
  }
  cat(content)
}
sink()

