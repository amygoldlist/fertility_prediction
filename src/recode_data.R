##clean_data.R
##by Amy Goldlist, January 2018

## Usage:  Rscript src/recode_data.R input_file output_file
## This script takes the clean csv (test or training) and outputs a numeric csv
## This will make it easier to work in sklearn
## This should be called twice


library(tidyverse)

# read in command line argument
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]




###read new CSV files
data <- read.csv(input_file)
##data <- read.csv("results/grades_train.csv")

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

write_csv(data_int, output_file)