###This script takes the ; seperated file and saves it as a proper csv
##As well, we're going to ditch G1 and G2, the midterm grades and only focus on the final grade.


library(tidyverse)




data=read.table("data/student-mat.csv",sep=";",header=TRUE)

data <- data %>% 
  select(-G2,-G1)

write_csv(data, "results/math_grades.csv")

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

str(data)
