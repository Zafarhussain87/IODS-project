
#Zafar Hussain, 11.09.2018. Data Wrangling script


#Reading the data from the given URL in csv format

learning2014 <- read.csv('http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep="\t")
head(learning2014)

#Finding the structure of the data

str(learning2014)

#Finding the dimensions of the data

dim(learning2014)

#The data has 183 rows and 60 columns. The columns are different parameters of students, their grades, gender, age, attitude and 
# how they are performing. The parameters have different numeric values.  I guess these values are based on some measurement
# procedure to calculate the students' output.

#Making a dataset for the suggested variables

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

library(dplyr)

# creating a deep column
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

# creating a surf column
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# creating a stra column
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

#Convertint Attitude into scale 1-5 and making a new column as 'attitude'
learning2014$attitude <- learning2014$Attitude/10

columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

#Creating a new dataset for analysis and filtering out the values where point = 0 

learning2014_new <- select(learning2014, one_of(columns))

learning2014_new <- filter(learning2014_new, Points>0)

dim(learning2014_new)
str(learning2014_new)

#Writing a csv file
write.csv(learning2014_new, 'C:/Users/Zafar/Documents/GitHub/IODS-project/data/learning2014.csv', row.names=FALSE)

#Writing a text file in tablural format
write.table(learning2014_new, 'C:/Users/Zafar/Documents/GitHub/IODS-project/data/learning2014.txt')

#Finding the working directory of my file
(WD <- getwd()) #gives this output  "C:/Users/Zafar/Documents"

#Now setting the working directory to IODS folder
setwd('C:/Users/Zafar/Documents/GitHub/IODS-project')

#Reading the csv file and making sure that the structure is same as expected with 166 observations and 7 variables
data_read <- read.csv('C:/Users/Zafar/Documents/GitHub/IODS-project/data/learning2014.csv', sep=",")
head(data_read)
str(data_read)



