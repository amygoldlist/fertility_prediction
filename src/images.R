### This script creates graphs for the 10 selected features

library(tidyverse)
library(cowplot)


##import all of the data
train <- read.csv("results/grades_train.csv")
test <- read.csv("results/grades_test.csv")
#train_pred <- read.csv("results/training_predictions.csv", header = FALSE, col.names = "predicted")
#test_pred <- read.csv("results/test_predictions.csv", header=FALSE,col.names = "predicted")

##put the data all together
grades <- rbind(train,test)



pfailure <- grades %>% 
  ggplot(aes(x = failures, y = G3))+
  geom_jitter(alpha = 0.4, colour = "blue")+
  theme_bw()+
  labs(y = "Final Grade")


pguardian <- grades %>% 
  ggplot(aes(x = guardian, y = G3))+
  geom_boxplot()+
  theme_bw()+
  labs(y = "Final Grade")

ptravel <- grades %>% 
  ggplot(aes(x = traveltime, y = G3))+
  geom_jitter(alpha = 0.4, colour = "blue")+
  theme_bw()+
  labs(y = "Final Grade")

 pfedu <- grades %>% 
  ggplot(aes(x = Fedu, y = G3))+
   geom_jitter(alpha = 0.4, colour = "blue")+
  theme_bw()+
  labs(y = "Final Grade", x = "Father's Education")
 
 
pschoolsup <- grades %>% 
   ggplot(aes(x = schoolsup, y = G3))+
   geom_boxplot()+
   theme_bw()+
   labs(y = "Final Grade", x = "Extra School Support")
 
pschool <- grades %>% 
  ggplot(aes(x = school, y = G3))+
  geom_boxplot()+
  theme_bw()+
  labs(y = "Final Grade")

pstudy <- grades %>% 
  ggplot(aes(x = studytime, y = G3))+
  geom_jitter(alpha = 0.4, colour = "blue")+
  theme_bw()+
  labs(y = "Final Grade")


psex <- grades %>% 
  ggplot(aes(x = sex, y = G3))+
  geom_boxplot()+
  theme_bw()+
  labs(y = "Final Grade")

promantic <- grades %>% 
  ggplot(aes(x = romantic, y = G3))+
  geom_boxplot()+
  theme_bw()+
  labs(y = "Final Grade", x = "In a romantic relationship")

pfamsize <- grades %>% 
  ggplot(aes(x = famsize, y = G3))+
  geom_jitter(alpha = 0.4, colour = "blue")+
  theme_bw()+
  labs(y = "Final Grade", x = "Family Size")


final <- cowplot::plot_grid(
  pfailure,
  pguardian,
  ptravel,
  pfedu,
  pschoolsup,
  pschool,
  pfamsize,
  psex,
  pstudy,
  promantic
)

ggsave(filename ="results/images/final.png", plot = final, width = 8)
