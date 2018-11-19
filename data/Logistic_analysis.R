
alc <- read.csv("D:/Study Material/Introduction to Open Data Science/IODS-project/data/student_alc_consumption.csv")

dim(alc)

colnames(alc)




library(tidyr); library(dplyr); library(ggplot2)


# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
gather(alc) %>% glimpse

# draw a bar plot of each variable
gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()

#Studying alocohal consumption and its relationship with other variables such as sex, grades, average past failures, average age of both genders, and absences.


# produce summary statistics by group
alc %>% group_by(sex, high_use) %>% summarise(count = n(), mean_grade = mean(G3))

alc %>% group_by(sex, high_use) %>% summarise(count = n(), average_failures = mean(failures))

alc %>% group_by(sex, high_use) %>% summarise(count = n(), average_age = mean(age))


alc %>% group_by(sex, high_use) %>% summarise(count = n(), average_failures = mean(absences))

library(ggplot2)

plot1 <- ggplot(alc, aes(x = high_use, y = G3, col= sex))

plot1 + geom_boxplot() + ylab("grade") + ggtitle("Student grades by alcohol consumption and sex")

plot2 <- ggplot(alc, aes(x = high_use, y = absences, col= sex))

plot2 + geom_boxplot() + ggtitle("Student absences by alcohol consumption and sex")


plot3 <- ggplot(alc, aes(x = high_use, y = age, col= sex))

plot3 + geom_boxplot() + ggtitle("Student age by alcohol consumption and sex")

plot4 <- ggplot(alc, aes(x = high_use, y = goout, col= sex))
plot4 + geom_boxplot()

#Regression Model


rm <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")

summary(rm)

# print out the coefficients of the model
coef(rm)


# alc and dlyr are available 

# find the model with glm()
rm2 <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")

# compute odds ratios (OR)
OR <- coef(rm2) %>% exp()

# compute confidence intervals (CI)
CI <- confint(rm2) %>% exp()

# print out the odds ratios with their confidence intervals
cbind(OR, CI)


# alc, dplyr are available

# fit the model
rm3 <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")

# predict() the probability of high_use
probabilities <- predict(rm3, type = "response")

# add the predicted probabilities to 'alc'
alc <- mutate(alc, probability = probabilities)

# use the probabilities to make a prediction of high_use
alc <- mutate(alc, prediction = ifelse (probability > 0.5, TRUE, FALSE))

# see the last ten original classes, predicted probabilities, and class predictions
select(alc, failures, absences, sex, high_use, probability, prediction) %>% tail(10)

# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction)


# alc is available

# initialize a plot of 'high_use' versus 'probability' in 'alc'
g <- ggplot(alc, aes(x = probability, y = high_use, col= prediction))

# define the geom as points and draw the plot
g + geom_point()

# tabulate the target variable versus the predictions and see the relationship.
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table() %>%addmargins()



