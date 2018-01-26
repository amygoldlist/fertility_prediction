
##clean_data.R
##by Amy Goldlist, January 2018

## Usage:  Rscript src/clean_data.R 
## This script takes the raw math grades and creates 2 files
## The image is plots of each of the 29 features vs the target, G3
###First it takes the ; seperated file and saves it as a proper csv
##As well, we're going to ditch G1 and G2, the midterm grades and only focus on the final grade.
# Next, it will split the data into 2 files:  training and testing


library(tidyverse)

### read in data set
data=read.table("data/student-mat.csv",sep=";",header=TRUE)

##get rid of the intermediate grades
data <- data %>% 
  select(-G2,-G1)






##set seed for reproducability
set.seed(2346)
## create a random vector with 80% 1, to seperate training data
train <- rbinom(n=nrow(data), size = 1, prob = .8)

##add this to our dataframe
df <- data.frame(data, train =train)


###Cut into test and training data
data_train <- df %>% 
  filter(train ==1)%>% 
  select(-train)

data_test <- df %>% 
  filter(train ==0) %>% 
  select(-train)




###create new CSV files
write_csv(data_train, "results/grades_train.csv")
write_csv(data_test, "results/grades_test.csv")

