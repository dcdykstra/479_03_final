rm(list=ls())
library(tidyverse)
library(tidytext)

args = (commandArgs(trailingOnly = TRUE))
if (length(args) == 2){
  tsv = args[1]
  sentiment = args[2]
} else {
  cat('usage: Rscript hw.R <tsv> <sentiment>')
  stop()
}

f = read_tsv(toString(tsv)) %>% 
  dplyr::select(14, 3, 8, 9, 11) 

sentiment = read.csv(toString(sentiment))

colnames(f) <- c("review_body", "review_id", "star_rating", "helpful_votes", "vine")

sent <- f %>%
  unnest_tokens(word, review_body) %>% 
  inner_join(sentiment) %>% 
  group_by(review_id, star_rating, helpful_votes, vine) %>% 
  summarize(sentiment = mean(value))

smp_size <- floor(0.75 * nrow(sent))
train_ind <- sample(seq_len(nrow(sent)), size = smp_size)

train <- sent[train_ind, ]
test <- sent[-train_ind, ]

filename = gsub(".tsv", "", toString(tsv))

write.table(train, paste("train", toString(filename), ".tsv", sep = ""), row.names=FALSE, col.names=FALSE)
write.table(test, paste("test", toString(filename), ".tsv", sep = ""), row.names=FALSE, col.names=FALSE)
