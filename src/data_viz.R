grade <- read.csv("results/math_grades.csv")


###G3 is what we're predicting
str(grade)

plot(grade)
summary(grade)

##data viz here?

grade %>% 
  group_by(school) %>% 
  summarize(mean(G3))

##Let's do some plotting
plot(grade$school, grade$G3)

plot(grade$sex, grade$G3)
plot(grade$age, grade$G3)
plot(grade$address, grade$G3)
plot(grade$famsize, grade$G3)
plot(grade$Pstatus, grade$G3)
plot(grade$Medu, grade$G3)
plot(grade$Mjob, grade$G3)
plot(grade$Fjob, grade$G3)
plot(grade$reason, grade$G3)
plot(grade$guardian, grade$G3)
plot(grade$traveltime, grade$G3)
plot(grade$studytime, grade$G3)
plot(grade$reason, grade$G3)
plot(grade$reason, grade$G3)