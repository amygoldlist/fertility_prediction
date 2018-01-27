### stuff goes here

library(tidyverse)

train <- read.csv("results/grades_train.csv")
test <- read.csv("results/grades_test.csv")
train_pred <- read.csv("results/training_predictions.csv", header = FALSE, col.names = "predicted")
test_pred <- read.csv("results/test_predictions.csv", header=FALSE,col.names = "predicted")

train_set <- data.frame(train, predictions =train_pred)
test_set <- data.frame(test, predictions =test_pred)

train_set %>% 
  mutate(residual = G3 - predicted) %>% 
  ggplot(aes(y = G3, x = predicted))+
  geom_point()+
  theme_bw()


test_set %>% 
  mutate(residual = G3 - predicted) %>% 
  ggplot(aes(y = G3, x = predicted))+
  geom_point()+
  theme_bw()
