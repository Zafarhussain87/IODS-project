library("FactoMineR")

human_data <- read.csv("C:/Users/Zafar/Documents/GitHub/IODS-project/data/human_.csv", sep = ",", header = TRUE, row.names = 1)
dim(human_data)
head(human_data)

summary(human)

human_pca <- prcomp(human_data)

biplot(human_pca, cex=c(0.8,1), choices = 1:2, col=c("grey40", "deeppink2"))

human_std <- scale(human_data)
summary(human_std)

human_pca <- prcomp(human_std)

biplot(human_pca, choices = 1:2, cex=c(0.8,1), col=c("grey40", "deeppink2"))
s <- summary(human_pca)
s
pca_pr <- round(100*s$importance[2, ], digits = 1)

pc_lab <- paste0(names(pca_pr), " (", pca_pr, "%)")
pc_lab
# draw a biplot
biplot(human_pca,choices=1:2, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab[1], ylab = pc_lab[2])

screeplot(human_pca, npcs = 8, type = "lines", main = "Optimal number of PCs")

# Starting MCA for Tea Dataset

library(FactoMineR)
library(ggplot2)
library(dplyr)
library(tidyr)
data("tea")
dim(tea)
# the tea dataset and packages FactoMineR, ggplot2, dplyr and tidyr are available

# column names to keep in the dataset
keep_columns <- c("Tea", "How", "how", "sugar", "where", "lunch")

# select the 'keep_columns' to create a new dataset
tea_time <- select(tea, one_of(keep_columns))

# look at the summaries and structure of the data
summary(tea_time)
str(tea_time)


# visualize the dataset
gather(tea_time) %>% ggplot(aes(value), geom_bar(), theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))) + facet_wrap("key", scales = "free") 

# tea_time is available

# multiple correspondence analysis
mca <- MCA(tea_time, graph = FALSE)

# summary of the model
summary(mca)

# visualize MCA
plot(mca, invisible=c("ind"), habillage = "quali")





