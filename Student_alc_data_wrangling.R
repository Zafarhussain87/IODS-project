''' Zafar Hussain 17-11-2018 
Exercise 3: Logistic Regression 
Data Reference: https://archive.ics.uci.edu/ml/datasets/Student+Performance

'''

data_por <- read.table("D:/Study Material/Introduction to Open Data Science/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

data_math <- read.table("D:/Study Material/Introduction to Open Data Science/IODS-project/data/student-mat.csv", sep = ";" , header=TRUE)

str(data_math)
str(data_por)

dim(data_math)
dim(data_por)

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(data_math, data_por, by  = join_by, suffix = c(".math", ".por"))

glimpse(math_por)

str(math_por)
dim(math_por)

alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(data_math)[!colnames(data_math) %in% join_by]


for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)
dim(alc)




# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill= sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = ifelse (alc_use > 2, TRUE, FALSE))

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x= high_use))
g2 + geom_bar() 
# draw a bar plot of high_use by sex
g2 +geom_bar() + facet_wrap("sex")


# glimpse at the new combined data
glimpse(alc)
dim(alc)

write.csv(alc, "D:/Study Material/Introduction to Open Data Science/IODS-project/data/student_alc_consumption.csv",row.names=FALSE)


