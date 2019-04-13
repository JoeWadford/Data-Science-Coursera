# Coursera Getting and Cleaning Data
# week 3 quiz

## question 1. 

#### The American Community Survey distributes downloadable data about United States communities. 
#### Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#### https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#### and load the data into R. The code book, describing the variable names is here:
#### https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

#### Create a logical vector that identifies the households on greater than 10 acres who sold more than 
#### $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
#### Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

#### which(agricultureLogical)

#### What are the first 3 values that result?

setwd("C:/Users/joewa/OneDrive/Documents/Data Science Coursera/3_Getting_and_Cleaning_Data/Week3_Getting_and_Cleaning_Data")
if(!file.exists("./data")){dir.create("./data")} 
quizUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(quizUrl, destfile ="./data/agriculture.csv", method="curl") 
agriData <- read.csv("./data/agriculture.csv")

head(agriData)
names(agriData)
str(agriData$ACR)

library(dplyr)

rm(agricultureLogical)
agricultureLogical <- agriData[which(agriData$ACR == 3 & agriData$AGS ==6),]
head(select(agricultureLogical, ACR:AGS), 3)

## Question 2

#### Using the jpeg package read in the following picture of your instructor into R

#### https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

#### Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
#### (some Linux systems may produce an answer 638 different for the 30th quantile)

library("jpeg")
??readjpeg
jpegUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jpegUrl, destfile ="./data/jeff.jpg", mode = "wb")

jeffjpg <- readJPEG("./data/jeff.jpg", native = TRUE)
quantile(jeffjpg, probs = c(0.3, 0.8))
