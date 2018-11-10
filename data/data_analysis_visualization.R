#This file is for data analysis and visualization


#Question 1

learning_data <- read.csv('C:/Users/Zafar/Documents/GitHub/IODS-project/data/learning2014.csv', sep=",")
head(learning_data)
#structure and dimensions of the data
str(learning_data)
dim(learning_data)

#This dataset is about the students, their age, gender, their attitude, scored points , deep, surface and strategic learinng.
#By reading and analyzing this data we can study the outcome of students and we can understand that outcome based on different 
#parameteric values. for example, attitude cna help us to understand the points, gender can make some understandings about attitude etc.


#Question 2

library(ggplot2)

#Trying to find out the correaltion between different variables. 
pairs(learning_data)

#The result shows that the gender does not have any kind of specific outcome when paired with other variables. But the variables like
# age and attitude are highly correlated. The same way points and deep learning is correlated and shows significance. 
#attitude and age are also have significance results.

# creating a plot and trying to find the dependencies of points and attitude 
#There is a linear relationship between these two attributes.
plot1 <- ggplot(learning_data, aes(x = attitude, y = Points, col=gender))
plot1 <- plot1 + geom_point() +stat_smooth(method = lm)
plot1

#Shows the relationship between attitude and deep learning parameters. 
#The results can also been seen from the summary of both variables.
 
plot2 <- ggplot(learning_data, aes(attitude, deep, col = gender))
plot2 <- plot2 + geom_point()  +stat_smooth(method = lm)
plot2
#The result in this graph depicts that there is not any significant change in the attitude and deep learning of female students.

summary(learning_data$attitude)
summary(learning_data$deep)


#Shows the relationship between attitude and age parameters. The results can also been seen from the summary of both variables.
plot3 <- ggplot(learning_data, aes(x = Age, y = stra, col = gender))
plot3 <- plot3 + geom_point() + stat_smooth(method=lm)
plot3
#Here the result shows that witht the increase in age, the strategic learning for female students increased while
#the male are almost constant throughout the period.

summary(learning_data$Points)
summary(learning_data$stra)

summary(learning_data$Points)
summary(learning_data$gender)

library(ggfortify)
#Question 3 and 4 

#Fitting the model for Points on deep learning variable

lm1 <- lm(learning_data$Points~learning_data$deep, data = learning_data)
summary(lm1)

with(learning_data,plot(deep, Points))
abline(lm1)


#Fitting the model on Points for attitude variable
lm2 <- lm(learning_data$Points~learning_data$attitude, data = learning_data)
summary(lm2)

with(learning_data,plot(attitude, Points))
abline(lm2)


lm3 <- lm(learning_data$Points~learning_data$surf, data = learning_data)
summary(lm3)

with(learning_data,plot(surf, Points))
abline(lm3)

lm4 <- lm(learning_data$Points ~ learning_data$deep + learning_data$surf + learning_data$stra)
summary(lm4)

with(learning_data, plot(deep+surf+stra, Points))
abline(lm4)

#Question 5 
mod1 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod1, which = 1, size = 3, smooth.linetype = "blank") + ggtitle("Residuals vs Fitted Values")

mod2 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod2, which = 2, size = 3, smooth.linetype = "blank") + ggtitle("Normal Q-Q Plot")

mod3 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod3, which = 5, size = 3, smooth.linetype = "blank") + ggtitle("Residuals vs Leverage")


lm_fit <- lm(learning_data$Points~learning_data$attitude, data = learning_data)
autoplot(lm_fit, which = c(1,2,5), smooth.linetype = "blank")




