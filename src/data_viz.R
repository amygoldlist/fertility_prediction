


##data_viz.R
##by Amy Goldlist, January 2018

## Usage:  Rscript src/data_viz.R 
## This script takes the cleaned math grades and creates an image
## The image is plots of each of the 29 features vs the target, G3


##This script created png file with a histogram of the data, grouped by sex

# read in command line argument

library(tidyverse)
#library(cowplot)


grade <- read.csv("results/math_grades.csv")



##Let's do some plotting


png("results/images/grid.png", width=1200, height=1200, res=50)

par(mfrow=c(6,5))
par(mar = c(3, 3, 3, 3), oma = c(1, 1, 1, 1))

plot(grade$sex, grade$G3, main = "Sex")
plot(grade$age, grade$G3, main = "Age")
plot(grade$address, grade$G3), main ="Address")
plot(grade$famsize, grade$G3),main = "Family Size")
plot(grade$Pstatus, grade$G3,main = "Pstatus")
plot(grade$Medu, grade$G3, main = "Mother Education")
plot(grade$Fedu, grade$G3, main = "Father Education")
plot(grade$Mjob, grade$G3, main ="Mother job")
plot(grade$Fjob, grade$G3, main ="Fatether Job")
plot(grade$reason, grade$G3, main ="Reason")
plot(grade$guardian, grade$G3, main ="Guardian")
plot(grade$traveltime, grade$G3, main ="Travel Time")
plot(grade$studytime, grade$G3, main ="Study Time")
plot(grade$failures, grade$G3, main ="Failures")
plot(grade$schoolsup, grade$G3, main ="School Supplies")
plot(grade[16], grade$G3, main ="Famsup")
plot(grade[17], grade$G3, main ="Paid")
plot(grade[18], grade$G3, main ="Activities")
plot(grade[19], grade$G3, main ="Nursery")
plot(grade[20], grade$G3, main ="Higher")
plot(grade[21], grade$G3, main ="Internet")
plot(grade[22], grade$G3, main = "Romantic")
plot(grade[23], grade$G3,main ="Family Relationship")
plot(grade$freetime, grade$G3, main ="Free Time")
plot(grade$goout, grade$G3, main = "Go Out?")
plot(grade$Dalc, grade$G3, main = "Dalc")
plot(grade$Walc, grade$G3, main ="Walc")
plot(grade$health, grade$G3,main ="Health")
plot(grade$absences, grade$G3,main="Absences")

dev.off()




