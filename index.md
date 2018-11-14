---
title: "IODS course project"
author: "Zafar Hussain"
output:
   html_document:
    keep_md: true
    theme: cosmo
    toc: true
    toc_depth: 2
    fig_caption: true
    fig_width: 6
    fig_height: 4
    code_folding: hide
---

***
  


# About the project

*Write a short description about the course and add a link to your github repository here. This is an R markdown (.Rmd) file so you can use R markdown syntax. See the 'Useful links' page in the mooc area (chapter 1) for instructions.*

## Course:
I got interested in this course after looking at the course content. The course covers important topic from the field of data science such as regression, logistic regression, clustering, classification, analysis and most importantly it gives an opportunity to learn R. 
Instead of learning R separately and learning the above mentioned topics in some other course, this course provides the platform to learn and practice at the same time. 

## My Repository:
https://github.com/Zafarhussain87/IODS-project

  
***
  

# Data Wrangling and Analysis

*In this chapter, we tried to learn how to clean up the data and how to make it ready for the anaysis phase.*

**Data Wrangling:**

I read the data from the given URL into csv format. 
I checked its structure and dimensions and matched them with the information given in the start of the exercise.
Then i added deep, strategic, and surface learning columns by combining different columns related to the mentioned categories. 
Then i created a new dataset with the 7 variables as instructed and saved in a csv and tabular form in my local directory.

```r
learning_data <- read.csv('C:/Users/Zafar/Documents/GitHub/IODS-project/data/learning2014.csv', sep=",")
head(learning_data)
```

```
##   gender Age attitude     deep  stra     surf Points
## 1      F  53      3.7 3.583333 3.375 2.583333     25
## 2      M  55      3.1 2.916667 2.750 3.166667     12
## 3      F  49      2.5 3.500000 3.625 2.250000     24
## 4      M  53      3.5 3.500000 3.125 2.250000     10
## 5      M  49      3.7 3.666667 3.625 2.833333     22
## 6      F  38      3.8 4.750000 3.625 2.416667     21
```

```r
str(learning_data)
```

```
## 'data.frame':	166 obs. of  7 variables:
##  $ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
##  $ Age     : int  53 55 49 53 49 38 50 37 37 42 ...
##  $ attitude: num  3.7 3.1 2.5 3.5 3.7 3.8 3.5 2.9 3.8 2.1 ...
##  $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
##  $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
##  $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
##  $ Points  : int  25 12 24 10 22 21 21 31 24 26 ...
```

```r
dim(learning_data)
```

```
## [1] 166   7
```

**Data Analysis:**

For this phase i read the newly created dataset from my local directory.
I created pairs plots to check and understand the correlations between variables. 
After that i plotted some simple results to check the relationships between attitude of students and their deep learning, age and their strategic learning , points and their attitude. 

```r
library(ggplot2)
pairs(learning_data)
```

![](index_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


I had to understand the relationship of these variables and compare them with each other for better understanding. 
Then i tried to fit linear models on the same variables and extracted their summaries.

```r
plot1 <- ggplot(learning_data, aes(x = attitude, y = Points, col=gender))
plot1 <- plot1 + geom_point() +stat_smooth(method = lm)
plot1
```

![](index_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
plot2 <- ggplot(learning_data, aes(attitude, deep, col = gender))
plot2 <- plot2 + geom_point()  +stat_smooth(method = lm)
plot2
```

![](index_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
summary(learning_data$attitude)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.400   2.600   3.200   3.143   3.700   5.000
```

```r
summary(learning_data$deep)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.583   3.333   3.667   3.680   4.083   4.917
```

```r
plot3 <- ggplot(learning_data, aes(x = Age, y = stra, col = gender))
plot3 <- plot3 + geom_point() + stat_smooth(method=lm)
plot3
```

![](index_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

In the last, as suggested, i made some plots to compare the Residulas and fitted models difference, normal Q-Q plots and Residuals and Leverage. 


```r
library(ggfortify)
mod1 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod1, which = 1, size = 3, smooth.linetype = "blank") + ggtitle("Residuals vs Fitted Values")
```

![](index_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
mod2 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod2, which = 2, size = 3, smooth.linetype = "blank") + ggtitle("Normal Q-Q Plot")
```

![](index_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

```r
mod3 <- lm(learning_data$Points ~ learning_data$attitude)
autoplot(mod3, which = 5, size = 3, smooth.linetype = "blank") + ggtitle("Residuals vs Leverage")
```

![](index_files/figure-html/unnamed-chunk-6-3.png)<!-- -->

The results indicate that there are few variables which are highly correlated with some other variables. Like attitude is correlated with Points or we can say that Points are dependent on attitude. Similarly, Points and deep are correlated. 
Gender and age does not show any kind of strong correlation with other variabels. 



***


