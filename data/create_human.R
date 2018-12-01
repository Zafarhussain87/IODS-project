# read the human data
hdi <-read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# look at the (column) names of human
names(hdi)

colnames(hdi) <- c("HDIRank", "Country","HDI", "LifeExp", "ExpEducation", "AvgEducation", "GNI", "GNI_Minus_Rank")
# look at the structure of human
str(hdi)

# print out summaries of the variables
summary(hdi)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# look at the (column) names of human
names(gii)
colnames(gii) <- c("GIIRank", "Country", "GII", "MotherLife", "AdoBirth", "parliamentF", "EduF", "EduM", "LaborF", "LaborM")
gii$EduF2M <- gii$EduF/gii$EduM
gii$LaborF2M <- gii$LaborF/gii$LaborM


# look at the structure of human
str(gii)

# print out summaries of the variables
summary(gii)

#Joining both hdi and gii dataframes with Country. 

human <- merge(hdi, gii,by="Country")
dim(human)
names(human)

summary(human)

library(GGally)
library(stringr)
library(dplyr)
library(corrplot)
str(human$GNI)
human$GNI <- str_replace(human$GNI, pattern = ",", replace = "") %>% as.numeric()

keep <- c("Country","EduF2M", "LaborF2M", "LifeExp", "ExpEducation", "GNI", "MotherLife", "AdoBirth", "parliamentF" )
human <- select(human, one_of(keep))

complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))


tail(human, 10)

last <- nrow(human)-7

human <- human[1:last, ]
rownames(human) <- human$Country

human_ <- select(human, -Country)
ggpairs(human_)
cor(human_) %>% corrplot()
dim(human_)


write.csv(human_, "human_.csv")

human_data <- read.csv("C:/Users/Zafar/Documents/GitHub/IODS-project/data/human_.csv", sep = ",", header = TRUE, row.names = 1)
dim(human_data)
head(human_data)

