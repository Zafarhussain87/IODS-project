# read the human data
hdi <-read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# look at the (column) names of human
names(hdi)

colnames(hdi) <- c("HDIRank", "Country","HDIIndex", "BirthLifeExp", "ExpEducation_year", "AvgEducation_year", "GNIPerCapita", "GNIPC_without_Rank")
# look at the structure of human
str(hdi)

# print out summaries of the variables
summary(hdi)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# look at the (column) names of human
names(gii)
colnames(gii) <- c("GIIRank", "Country", "GiiIndex", "MotherLifeExp", "TeenageBirthRate", "ReprinParliament", "SecEduFemale", "SecEduMale", "LaborFemale", "LaborMale")
gii$EduF2M <- gii$SecEduFemale/gii$SecEduMale
gii$LaborF2M <- gii$LaborFemale/gii$LaborMale


# look at the structure of human
str(gii)

# print out summaries of the variables
summary(gii)

#Joining both hdi and gii dataframes with Country. 

human <- merge(hdi, gii,by="Country")
dim(human)

