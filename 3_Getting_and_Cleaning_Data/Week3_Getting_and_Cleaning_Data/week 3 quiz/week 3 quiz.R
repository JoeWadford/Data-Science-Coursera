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
head(select(agricultureLogical, ACR:AGS),3)

#     ACR AGS
# 125   3   6
# 238   3   6
# 262   3   6

## Question 2. 

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

#       30%       80% 
# -15259150 -10575416 

## Question 3

#### Load the Gross Domestic Product data for the 190 ranked countries in this data set:

#### https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

#### Load the educational data from this data set:

#### https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

#### Match the data based on the country shortcode. How many of the IDs match? 
#### Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

#### Original data sources:

#### http://data.worldbank.org/data-catalog/GDP-ranking-table
#### http://data.worldbank.org/data-catalog/ed-stats

gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
educUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(gdpUrl, destfile = "./data/gdp.csv", method = "curl")
gdp <- data.table::fread("./data/gdp.csv", skip = 5, nrows = 190, select = c(1,2,4,5), 
                         col.names = c("CountryCode", "gdpRank", "CountryName","GDP"))
view(gdp)

download.file(educUrl, destfile="./data/educ.csv", method = "curl")
educ <- data.table::fread("./data/educ.csv")

view(educ)

mergedData <- merge(gdp, educ, by = "CountryCode")

nrow(mergedData)

# [1] 189

#### there are two ways to do this, arrange by GDP or gdprank
#### GDP needs to be transformed to numeric from character

library(plyr)
mergedData$GDP <- as.numeric(gsub(",", "", mergedData$GDP))

arrangeData <- arrange(mergedData, desc(gdpRank))
test <- tail(arrangeData,1)
test[,1]

#    CountryCode
# 1:         USA

arrangeData[13, list(CountryCode, CountryName, gdpRank, GDP)]

#### OR

mergedData[order(gdpRank, decreasing = TRUE), list(CountryCode, CountryName, gdpRank, GDP)][13]

#    CountryCode         CountryName gdpRank GDP
# 1:         KNA St. Kitts and Nevis     178 767

## Question 4

#### What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

mean(arrangeData$gdpRank[arrangeData$`Income Group` =="High income: nonOECD"])

# [1] 91.91304

mean(arrangeData$gdpRank[arrangeData$`Income Group` =="High income: OECD"])

# [1] 32.96667

## Question 5

#### Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#### How many countries are Lower middle income but among the 38 nations with highest GDP?

breaks <- quantile(arrangeData$gdpRank, probs = seq(0,1,.2), na.rm = TRUE)
arrangeData$quantile <- cut(arrangeData$gdpRank, breaks=breaks)

table(arrangeData$'Income Group', arrangeData$quantile)

#                       (1,38.6] (38.6,76.2] (76.2,114] (114,152] (152,190]
#  High income: nonOECD        4           5          8         4         2
#  High income: OECD          17          10          1         1         0
#  Low income                  0           1          9        16        11
#  Lower middle income         5          13         11         9        16
#  Upper middle income        11           9          8         8         9
