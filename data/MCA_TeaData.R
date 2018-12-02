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


