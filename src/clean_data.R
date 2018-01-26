
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

### recode all factors as numbers

data_int <- data %>% 
  mutate(school = as.numeric(school),
         sex = as.numeric(sex),
         address = as.numeric(address),
         famsize = as.numeric(famsize),
         Pstatus = as.numeric(Pstatus),
         Mjob = as.numeric(Mjob),
         Fjob = as.numeric(Fjob),
         reason = as.numeric(reason),
         guardian = as.numeric(guardian),
         schoolsup=as.numeric(schoolsup),
         famsup=as.numeric(famsup),
         paid = as.numeric(paid),
         activities=as.numeric(activities),
         nursery = as.numeric(nursery),
         higher = as.numeric(higher),
         internet = as.numeric(internet),
          romantic = as.numeric(romantic)
         ) 
  
write_csv(data_int, "results/int_grades.csv")

#str(data)
