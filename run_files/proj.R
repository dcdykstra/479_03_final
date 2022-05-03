rm(list=ls())
library(caret)
library(tidyverse)
train = read_table("train.csv", col_names=FALSE)
test = read_table("test.csv", col_names=FALSE)
colnames(test) <- c("review_id", "star_rating", "helpful_votes", "vine", "sentiment")
colnames(train) <- c("review_id", "star_rating", "helpful_votes", "vine", "sentiment")
lm = lm(star_rating~sentiment+helpful_votes+vine, data=train)

sink("lm.txt")
print(summary(lm))
sink()

y_pred_cont = predict(lm, test)

y_pred_cat <- round(y_pred_cont, digits=0)
y_pred_cat <- replace(y_pred_cat, y_pred_cat>5, 5)
y_pred_cat <- as.factor(replace(y_pred_cat, y_pred_cat<1, 1))
y_pred_cat <- droplevels(y_pred_cat)

y_true = as.factor(test$star_rating)

y = data.frame(y_pred_cont, y_pred_cat, y_true)

result <- confusionMatrix(y_pred_cat, y_true)

sink("conf_mat.txt")
print(result)
sink()