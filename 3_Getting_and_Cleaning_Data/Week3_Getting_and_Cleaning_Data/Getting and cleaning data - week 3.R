# Coursera - Getting and Cleaning Data - Week 3
# Notes and such

## subsetting and sorting

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA

#### X[sample(1:5,] scrambles the rows

X

#   var1 var2 var3
# 1    2   NA   15
# 4    1   10   11
# 2    3   NA   12
# 3    5    6   14
# 5    4    9   13

X[,1]

# [1] 2 1 3 5 4

X[,"var1"]

# [1] 2 1 3 5 4

X[1:2, "var2"]

# [1] NA 10

X[(X$var1 <= 3 & X$var3 > 11),]

#### just the rows where variable 1 <= 3 AND var3 > 11

#   var1 var2 var3
# 1    2   NA   15
# 2    3   NA   12

X[(X$var1 <= 3 | X$var3 > 15),]

#   var1 var2 var3
# 1    2   NA   15
# 4    1   10   11
# 2    3   NA   12

X[which(X$var2 > 8),]

#### which = Give the TRUE indices of a logical object, allowing for array indices.

#   var1 var2 var3
# 4    1   10   11
# 5    4    9   13

sort(X$var1)

# [1] 1 2 3 4 5

sort(X$var1, decreasing = TRUE)

# [1] 5 4 3 2 1

sort(X$var2, na.last = TRUE)

# [1]  6  9 10 NA NA

X[order(X$var1),]

#### subsets X while putting var1 in order, from smallest to largest as default

#   var1 var2 var3
# 4    1   10   11
# 1    2   NA   15
# 2    3   NA   12
# 5    4    9   13
# 3    5    6   14

X[order(X$var1, X$var3),]

#### subsets X while putting var1 in order, followed by var 3 if there are any of the same variables in var 1

#   var1 var2 var3
# 4    1   10   11
# 1    2   NA   15
# 2    3   NA   12
# 5    4    9   13
# 3    5    6   14

### Ordering with plyr

arrange(X, var1)

#   var1 var2 var3
# 1    1   10   11
# 2    2   NA   15
# 3    3   NA   12
# 4    4    9   13
# 5    5    6   14

arrange(X, desc(var1))

#   var1 var2 var3
# 1    5    6   14
# 2    4    9   13
# 3    3   NA   12
# 4    2   NA   15
# 5    1   10   11

X$var4 <- rnorm(5)

#### adding a column

X

#   var1 var2 var3       var4
# 1    2   NA   15  0.1875960
# 4    1   10   11  1.7869764
# 2    3   NA   12  0.4966936
# 3    5    6   14  0.0631830
# 5    4    9   13 -0.5361329

Y <- cbind(X, rnorm(5))

#### binding another column to X dataset

Y

#   var1 var2 var3       var4    rnorm(5)
# 1    2   NA   15  0.1875960  0.62578490
# 4    1   10   11  1.7869764 -2.45083750
# 2    3   NA   12  0.4966936  0.08909424
# 3    5    6   14  0.0631830  0.47838570
# 5    4    9   13 -0.5361329  1.00053336

## summarizing data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile ="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")

head(restData,n=3)

#    name zipCode neighborhood councilDistrict policeDistrict                      Location.1
# 1   410   21206    Frankford               2   NORTHEASTERN 4509 BELAIR ROAD\nBaltimore, MD
# 2  1919   21231  Fells Point               1   SOUTHEASTERN    1919 FLEET ST\nBaltimore, MD
# 3 SAUTE   21224       Canton               1   SOUTHEASTERN   2844 HUDSON ST\nBaltimore, MD

tail(restData,n=3)

#              name zipCode  neighborhood councilDistrict policeDistrict                       Location.1
# 1325 ZINK'S CAF   21213 Belair-Edison              13   NORTHEASTERN 3300 LAWNVIEW AVE\nBaltimore, MD
# 1326 ZISSIMOS BAR   21211       Hampden               7       NORTHERN      1023 36TH ST\nBaltimore, MD
# 1327       ZORBAS   21224     Greektown               2   SOUTHEASTERN  4710 EASTERN Ave\nBaltimore, MD

summarize(restData,n=3)

#                           name         zipCode             neighborhood councilDistrict       policeDistrict
# MCDONALD'S                  :   8   Min.   :-21226   Downtown    :128   Min.   : 1.000   SOUTHEASTERN:385   
# POPEYES FAMOUS FRIED CHICKEN:   7   1st Qu.: 21202   Fells Point : 91   1st Qu.: 2.000   CENTRAL     :288   
# SUBWAY                      :   6   Median : 21218   Inner Harbor: 89   Median : 9.000   SOUTHERN    :213   
# KENTUCKY FRIED CHICKEN      :   5   Mean   : 21185   Canton      : 81   Mean   : 7.191   NORTHERN    :157   
# BURGER KING                 :   4   3rd Qu.: 21226   Federal Hill: 42   3rd Qu.:11.000   NORTHEASTERN: 72   
# DUNKIN DONUTS               :   4   Max.   : 21287   Mount Vernon: 33   Max.   :14.000   EASTERN     : 67   
# (Other)                     :1293                    (Other)     :863                    (Other)     :145   
#                         Location.1   
# 1101 RUSSELL ST\nBaltimore, MD:   9  
# 201 PRATT ST\nBaltimore, MD   :   8  
# 2400 BOSTON ST\nBaltimore, MD :   8  
# 300 LIGHT ST\nBaltimore, MD   :   5  
# 300 CHARLES ST\nBaltimore, MD :   4  
# 301 LIGHT ST\nBaltimore, MD   :   4  
# (Other)                       :1289 

str(restData)

# 'data.frame':	1327 obs. of  6 variables:
#  $ name           : Factor w/ 1277 levels "#1 CHINESE KITCHEN",..: 9 3 992 1 2 4 5 6 7 8 ...
#  $ zipCode        : int  21206 21231 21224 21211 21223 21218 21205 21211 21205 21231 ...
#  $ neighborhood   : Factor w/ 173 levels "Abell","Arlington",..: 53 52 18 66 104 33 98 133 98 157 ...
#  $ councilDistrict: int  2 1 1 14 9 14 13 7 13 1 ...
#  $ policeDistrict : Factor w/ 9 levels "CENTRAL","EASTERN",..: 3 6 6 4 8 3 6 4 6 6 ...
#  $ Location.1     : Factor w/ 1210 levels "1 BIDDLE ST\nBaltimore, MD",..: 835 334 554 755 492 537 505 530 507 569 ...

quantile(restData$councilDistrict,na.rm=TRUE)

#  0%  25%  50%  75% 100% 
#   1    2    9   11   14 

quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))

# 50% 75% 90% 
#   9  11  12 

table(restData$zipCode,useNA="ifany")

#### ifany will tabulate NAs if there are any

# -21226  21201  21202  21205  21206  21207  21208  21209  21210  21211  21212  21213  21214  21215  21216  21217  21218  21220  21222  21223 
#      1    136    201     27     30      4      1      8     23     41     28     31     17     54     10     32     69      1      7     56 
#  21224  21225  21226  21227  21229  21230  21231  21234  21237  21239  21251  21287 
#    199     19     18      4     13    156    127      7      1      3      2      1 

table(restData$councilDistrict,restData$zipCode)

#    21226 21227 21229 21230 21231 21234 21237 21239 21251 21287
#  1      0     0     0     1   124     0     0     0     0     0
#  2      0     0     0     0     0     0     1     0     0     0
#  3      0     1     0     0     0     7     0     0     2     0
#  4      0     0     0     0     0     0     0     3     0     0
#  5      0     0     0     0     0     0     0     0     0     0
#  6      0     0     0     0     0     0     0     0     0     0
#  7      0     0     0     0     0     0     0     0     0     0
#  8      0     2    13     0     0     0     0     0     0     0
#  9      0     0     0    11     0     0     0     0     0     0
#  10    18     0     0   133     0     0     0     0     0     0
#  11     0     0     0    11     0     0     0     0     0     0
#  12     0     0     0     0     2     0     0     0     0     0
#  13     0     1     0     0     1     0     0     0     0     1
#  14     0     0     0     0     0     0     0     0     0     0

#### And so, for example, you see that district ten has 18 restaurants in the 21226 zip code. And so you can do this for different 
#### qualitative variables and get a sense of the relationship between those variables.

sum(is.na(restData$councilDistrict))

# [1] 0

any(is.na(restData$councilDistrict))
    
    # [1] FALSE
    
all(restData$zipCode > 0)
    
    # [1] FALSE
    
colSums(is.na(restData))
    
    #           name         zipCode    neighborhood councilDistrict  policeDistrict      Location.1 
    #              0               0               0               0               0               0 
    
all(colSums(is.na(restData))==0)
    
    # [1] TRUE
    
table(restData$zipCode %in% c("21212"))
    
    # FALSE  TRUE 
    #  1299    28 
    
table(restData$zipCode %in% c("21212","21213"))
    
    # FALSE  TRUE 
    #  1268    59 
    
restData[restData$zipCode %in% c("21212", "21213"),]

    #### subsetting a dataset based on two variables in a column
    
    #                                     name zipCode                neighborhood councilDistrict policeDistrict
    # 29                      BAY ATLANTIC CLUB   21212                    Downtown              11        CENTRAL
    # 39                            BERMUDA BAR   21213               Broadway East              12        EASTERN
    # 92                              ATWATER'S   21212   Chinquapin Park-Belvedere               4       NORTHERN
    # 111            BALTIMORE ESTONIAN SOCIETY   21213          South Clifton Park              12        EASTERN
    # 187                              CAFE ZEN   21212                    Rosebank               4       NORTHERN
    # 54 more rows...
    
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
    
    #      Admit       Gender   Dept       Freq      
    # Admitted:12   Male  :12   A:4   Min.   :  8.0  
    # Rejected:12   Female:12   B:4   1st Qu.: 80.0  
    #                           C:4   Median :170.0  
    #                           D:4   Mean   :188.6  
    #                           E:4   3rd Qu.:302.5  
    #                           F:4   Max.   :512.0  
    
    ### xtabs

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

    #### frequency based on gender and admission
    
    #         Admit
    # Gender   Admitted Rejected
    #   Male       1198     1493
    #   Female      557     1278
    
xt = xtabs(breaks ~.,data=warpbreaks)
xt
    
    # , , replicate = 1
    
    #     tension
    # wool  L  M  H
    #    A 26 18 36
    #    B 27 42 20
    # 8 more replicates, tensions, and wools
    
ftable(xt)

    ####ftable displays it in a compact form
    
    #              replicate  1  2  3  4  5  6  7  8  9
    # wool tension                                     
    # A    L                 26 30 54 25 70 52 51 26 67
    #      M                 18 21 29 17 12 18 35 30 36
    #      H                 36 21 24 18 10 43 28 15 26
    # B    L                 27 14 29 19 29 31 41 20 44
    #      M                 42 26 19 16 39 28 21 39 29
    #      H                 20 21 24 17 13 15 15 16 28
    
fakeData = rnorm(1e5)
object.size(fakeData)
    
    # 800040 bytes
    
## Creating New Variables

### why create new variables?

#### often the raw data won't have what you're looking for
#### you will need to tranform the data to get the values you would like
#### usually you will add those values to the data frames you are working with
#### common variables to create = missingness variables, "cutting up" quantitative variables,
#### applying transforms

setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Notes/Getting and cleaning data - week 3")
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")    

### creating sequences

s1 <- seq(1,10,by=2)
s1

# [1] 1 3 5 7 9

s2 <- seq(1,10, length=3)
s2

# [1]  1.0  5.5 10.0

x <- c(1,3,8,25,100)
seq(along=x)

# [1] 1 2 3 4 5


### Subsetting variables

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# FALSE  TRUE 
#  1314    13 

### Creating binary variables

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode <0)

#         FALSE TRUE
#   FALSE  1326    0
#   TRUE      0    1

### Creating categorical variables

restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

# (-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] (2.123e+04,2.129e+04] 
#                   337                   375                   282                   332 

table(restData$zipGroups, restData$zipCode)

#                        21222 21223 21224 21225 21226 21227 21229 21230 21231 21234 21237 21239 21251 21287
#  (-2.123e+04,2.12e+04]     0     0     0     0     0     0     0     0     0     0     0     0     0     0
#  (2.12e+04,2.122e+04]      0     0     0     0     0     0     0     0     0     0     0     0     0     0
#  (2.122e+04,2.123e+04]     7    56   199    19     0     0     0     0     0     0     0     0     0     0
#  (2.123e+04,2.129e+04]     0     0     0     0    18     4    13   156   127     7     1     3     2     1

### Easier cutting
### cutting produces factor variables

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
#            338            375            300            314 

### Creating factor variables

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

# [1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
# 32 Levels: -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214 21215 21216 21217 21218 21220 21222 21223 21224 21225 ... 21287

class(restData$zcf)

# [1] "factor"

### Levels of factor variables

yesno <- sample(c("yes","no"), size = 10,replace=TRUE)
yesnofac <- factor(yesno, levels=c("yes","no"))
relevel(yesnofac,ref="yes")

# [1] yes no  no  no  no  no  yes yes yes yes
# Levels: yes no

as.numeric(yesnofac)

# [1] 1 2 2 2 2 2 1 1 1 1

### Using the mutate function

library(plyr)
restData2 = mutate(restData,zipGroups = cut2(zipCode,g=4))
table(restData2$zipGroups)

# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
#           338            375            300            314 

### Common Transforms

# abs(x) absolute value
# sqrt(x) square root
# ceiling(x) ceiling(3.475) is 4
# floor(x) floor(3.475) is 3
# round(x, digits=n) round(3.475,digits=2) is 3.48
# signif(x,digits=n) signif(3.475,digits=2) is 3.5
# cos(x), sin(x), etc
# log(x) natural logarithm
# log2(x), log10(x) other common logs
# exp(x) exponentiating x


## Reshaping Data

### the goal is tidy data

        # 1. each variable forms a column
        # 2. each observation forms a row
        # 3. each table/file stores data about one kind of observation (e.g. people/hospitals)

### Start with reshaping

library(reshape2)
head(mtcars)

#                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
# Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

### Melting data frames

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"),measure.vars = c("mpg","hp"))
head(carMelt,n=3)

#         carname gear cyl variable value
# 1     Mazda RX4    4   6      mpg  21.0
# 2 Mazda RX4 Wag    4   6      mpg  21.0
# 3    Datsun 710    4   4      mpg  22.8

tail(carMelt,n=3)

#          carname gear cyl variable value
# 62  Ferrari Dino    5   6       hp   175
# 63 Maserati Bora    5   8       hp   335
# 64    Volvo 142E    4   4       hp   109

### Casting data frames

cylData <- dcast(carMelt, cyl ~ variable)

#### Aggregation function missing: defaulting to length
#### this isn't an error - it is a warning

cylData

#   cyl mpg hp
# 1   4  11 11
# 2   6   7  7
# 3   8  14 14

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

#   cyl      mpg        hp
# 1   4 26.66364  82.63636
# 2   6 19.74286 122.28571
# 3   8 15.10000 209.21429

### Averaging values

head(InsectSprays)

#   count spray
# 1    10     A
# 2     7     A
# 3    20     A
# 4    14     A
# 5    14     A
# 6    12     A

tapply(InsectSpray$count,InsectSpray$spray,sum)

#   A   B   C   D   E   F 
# 174 184  25  59  42 200 

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

# $A
#  [1] 10  7 20 14 14 12 10 23 17 20 14 13

# $B
#  [1] 11 17 21 11 16 14 17 17 19 21  7 13

# $C
#  [1] 0 1 7 2 3 1 2 1 3 0 1 4

# $D
#  [1]  3  5 12  6  4  3  5  5  5  5  2  4

# $E
#  [1] 3 5 3 5 3 6 1 1 3 2 6 4

# $F
#  [1] 11  9 15 22 15 16 13 10 26 26 24 13

### Another way - apply

sprCount = lapply(spIns,sum)
sprCount

# $A
# [1] 174

# $B
# [1] 184

# $C
# [1] 25

# $D
# [1] 59

# $E
# [1] 42

# $F
# [1] 200

### Another way - combine 

unlist(sprCount)

#   A   B   C   D   E   F 
# 174 184  25  59  42 200

sapply(spIns,sum)

#   A   B   C   D   E   F 
# 174 184  25  59  42 200

### Another way - plyr package

ddply(InsectSprays,.(spray),summarize,sum=sum(count))

#   spray sum
# 1     A 174
# 2     B 184
# 3     C  25
# 4     D  59
# 5     E  42
# 6     F 200

### Creating a new variable

spraySums <- ddply(InsectSprays,.(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)

# [1] 72  2

head(spraySums)

#   spray sum
# 1     A 174
# 2     A 174
# 3     A 174
# 4     A 174
# 5     A 174
# 6     A 174

### More information

# acast - for casting as multi-dimensional arrays
# arrange - for faster reordering without using order() commands
# mutate - adding new variables

## Managing data frames with dplyr - Introduction
## see also "getting and cleaning data" swirl lessons

### the data frame is a key data structure in statistics and in R

# there is one observation per row
# Each column represents a variable or measure or characteristic
# Primary implementation that you will use is the default R implementation
# other implementations, particularly relational databases systems

### dplyr

# Developed by Hadley wickham of RStudio
# An optimized and distilled version of plyr package (also by Hadley)
# Does not provide any "new" functionality per se, but greatly simplifies existing functionality in R
# Provides a "grammar" (in particular, verbs) for data manipulation
# Is very fast, as many key operations are coded in C++

### dplyr Verbs

# select: return a subset of the columns of a data frame
# filter: extract a subset of rows from a data frame based on logical conditions
# arrange: render rows of a data frame
# rename: rename variables in a data frame
# mutate: add new variables/columns or transform existing variables
# summarize/summarise: generate summary statistics of different variables in the data frame, possibly within strata

### dplyr Properties

# The first argument is a data frame
# The subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without
# using the $ operator (just use the names).
# The result is a new data frame
# Data frames must be properly formatted and annonated for this to all be useful

## Managing Data Frames with dplyr - Basic Tools

### Using the tools

library(dplyr)
options(width = 105)

setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Notes/Getting and cleaning data - week 3")
fileURLchicago <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileURLchicago, destfile="./data/chicago.rds",method="curl", extra = '-L')
chicago <- readRDS("./data/chicago.rds")

dim(chicago)

# [1] 6940    8

str(chicago)

# 'data.frame':	6940 obs. of  8 variables:
#  $ city      : chr  "chic" "chic" "chic" "chic" ...
#  $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
#  $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
#  $ date      : Date, format: "1987-01-01" ...
#  $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
#  $ pm10tmean2: num  34 NA 34.2 47 NA ...
#  $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
#  $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...

names(chicago)

# [1] "city"       "tmpd"       "dptp"       "date"      
# [5] "pm25tmean2" "pm10tmean2" "o3tmean2"   "no2tmean2" 

head(select(chicago, city:dptp))

#   city tmpd   dptp
# 1 chic 31.5 31.500
# 2 chic 33.0 29.875
# 3 chic 33.0 27.375
# 4 chic 29.0 28.625
# 5 chic 32.0 28.875
# 6 chic 40.0 35.125

i <- match("city", names(chicago))

j <- match("dptp", names(chicago))

head(chicago[, -(i:j)])

#         date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 1987-01-02         NA         NA 3.304348  23.19099
# 3 1987-01-03         NA   34.16667 3.333333  23.81548
# 4 1987-01-04         NA   47.00000 4.375000  30.43452
# 5 1987-01-05         NA         NA 4.750000  30.33333
# 6 1987-01-06         NA   48.00000 5.833333  25.77233

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)

#    city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
# 1  chic   23 21.9 1998-01-17      38.10   32.46154  3.180556  25.30000
# 2  chic   28 25.8 1998-01-23      33.95   38.69231  1.750000  29.37630
# 3  chic   55 51.3 1998-04-30      39.40   34.00000 10.786232  25.31310
# 4  chic   59 53.7 1998-05-01      35.40   28.50000 14.295125  31.42905
# 5  chic   57 52.0 1998-05-02      33.30   35.00000 20.662879  26.79861
# 6  chic   57 56.0 1998-05-07      32.10   34.50000 24.270422  33.99167
# 7  chic   75 65.8 1998-05-15      56.50   91.00000 38.573007  29.03261
# 8  chic   61 59.0 1998-06-09      33.80   26.00000 17.890810  25.49668
# 9  chic   73 60.3 1998-07-13      30.30   64.50000 37.018865  37.93056
# 10 chic   78 67.1 1998-07-14      41.40   75.00000 40.080902  32.59054

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

#   city tmpd dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic   81 71.2 1998-08-23    39.6000       59.0 45.86364  14.32639
# 2 chic   81 70.4 1998-09-06    31.5000       50.5 50.66250  20.31250
# 3 chic   82 72.2 2001-07-20    32.3000       58.5 33.00380  33.67500
# 4 chic   84 72.9 2001-08-01    43.7000       81.5 45.17736  27.44239
# 5 chic   85 72.6 2001-08-08    38.8375       70.0 37.98047  27.62743
# 6 chic   84 72.6 2001-08-09    38.2000       66.0 36.73245  26.46742

chicago <- arrange(chicago, date)
head(chicago)

#   city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099
# 3 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548
# 4 chic 29.0 28.625 1987-01-04         NA   47.00000 4.375000  30.43452
# 5 chic 32.0 28.875 1987-01-05         NA         NA 4.750000  30.33333
# 6 chic 40.0 35.125 1987-01-06         NA   48.00000 5.833333  25.77233

tail(chicago)

#     city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
# 6935 chic   35 29.6 2005-12-26    8.40000        8.5 14.041667  16.81944
# 6936 chic   40 33.6 2005-12-27   23.56000       27.0  4.468750  23.50000
# 6937 chic   37 34.5 2005-12-28   17.75000       27.5  3.260417  19.28563
# 6938 chic   35 29.4 2005-12-29    7.45000       23.5  6.794837  19.97222
# 6939 chic   36 31.0 2005-12-30   15.05714       19.2  3.034420  22.80556
# 6940 chic   35 30.1 2005-12-31   15.00000       23.5  2.531250  13.25000

chicago <- arrange(chicago, desc(date))
head(chicago)

#   city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
# 1 chic   35 30.1 2005-12-31   15.00000       23.5  2.531250  13.25000
# 2 chic   36 31.0 2005-12-30   15.05714       19.2  3.034420  22.80556
# 3 chic   35 29.4 2005-12-29    7.45000       23.5  6.794837  19.97222
# 4 chic   37 34.5 2005-12-28   17.75000       27.5  3.260417  19.28563
# 5 chic   40 33.6 2005-12-27   23.56000       27.0  4.468750  23.50000
# 6 chic   35 29.6 2005-12-26    8.40000        8.5 14.041667  16.81944

tail(chicago)

#      city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 6935 chic 40.0 35.125 1987-01-06         NA   48.00000 5.833333  25.77233
# 6936 chic 32.0 28.875 1987-01-05         NA         NA 4.750000  30.33333
# 6937 chic 29.0 28.625 1987-01-04         NA   47.00000 4.375000  30.43452
# 6938 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548
# 6939 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099
# 6940 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810

chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

#   city tmpd dewpoint       date     pm25 pm10tmean2  o3tmean2 no2tmean2
# 1 chic   35     30.1 2005-12-31 15.00000       23.5  2.531250  13.25000
# 2 chic   36     31.0 2005-12-30 15.05714       19.2  3.034420  22.80556
# 3 chic   35     29.4 2005-12-29  7.45000       23.5  6.794837  19.97222
# 4 chic   37     34.5 2005-12-28 17.75000       27.5  3.260417  19.28563
# 5 chic   40     33.6 2005-12-27 23.56000       27.0  4.468750  23.50000
# 6 chic   35     29.6 2005-12-26  8.40000        8.5 14.041667  16.81944

chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))

#       pm25 pm25detrend
# 1 15.00000   -1.230958
# 2 15.05714   -1.173815
# 3  7.45000   -8.780958
# 4 17.75000    1.519042
# 5 23.56000    7.329042
# 6  8.40000   -7.830958

chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold

#### A tibble: 6,940 x 10
#### Groups:   tempcat [3]

#    city   tmpd dewpoint date        pm25 pm10tmean2 o3tmean2 no2tmean2 pm25detrend tempcat
#    <chr> <dbl>    <dbl> <date>     <dbl>      <dbl>    <dbl>     <dbl>       <dbl> <fct>  
#  1 chic     35     30.1 2005-12-31 15          23.5     2.53      13.2       -1.23 cold   
#  2 chic     36     31   2005-12-30 15.1        19.2     3.03      22.8       -1.17 cold   
#  3 chic     35     29.4 2005-12-29  7.45       23.5     6.79      20.0       -8.78 cold   
#  4 chic     37     34.5 2005-12-28 17.8        27.5     3.26      19.3        1.52 cold   
#  5 chic     40     33.6 2005-12-27 23.6        27       4.47      23.5        7.33 cold   
#  6 chic     35     29.6 2005-12-26  8.4         8.5    14.0       16.8       -7.83 cold   
#  7 chic     35     32.1 2005-12-25  6.7         8      14.4       13.8       -9.53 cold   
#  8 chic     37     35.2 2005-12-24 30.8        25.2     1.77      32.0       14.5  cold   
#  9 chic     41     32.6 2005-12-23 32.9        34.5     6.91      29.1       16.7  cold   
# 10 chic     22     23.3 2005-12-22 36.6        42.5     5.39      33.7       20.4  cold   
# ... with 6,930 more rows

summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))

#### A tibble: 3 x 4

#   tempcat  pm25    o3   no2
#   <fct>   <dbl> <dbl> <dbl>
# 1 cold     NA   66.6   24.5
# 2 hot      NA   63.0   24.9
# 3 NA       47.7  9.42  37.4

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

#### A tibble: 19 x 4

#     year  pm25    o3   no2
#    <dbl> <dbl> <dbl> <dbl>
#  1  1987 NaN    63.0  23.5
#  2  1988 NaN    61.7  24.5
#  3  1989 NaN    59.7  26.1
#  4  1990 NaN    52.2  22.6
#  5  1991 NaN    63.1  21.4
#  6  1992 NaN    50.8  24.8
#  7  1993 NaN    44.3  25.8
#  8  1994 NaN    52.2  28.5
#  9  1995 NaN    66.6  27.3
# 10  1996 NaN    58.4  26.4
# 11  1997 NaN    56.5  25.5
# 12  1998  18.3  50.7  24.6
# 13  1999  18.5  57.5  24.7
# 14  2000  16.9  55.8  23.5
# 15  2001  16.9  51.8  25.1
# 16  2002  15.3  54.9  22.7
# 17  2003  15.2  56.2  24.6
# 18  2004  14.6  44.5  23.4
# 19  2005  16.2  58.8  22.6

chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% 
        summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

#### A tibble: 12 x 4

#    month  pm25    o3   no2
#    <dbl> <dbl> <dbl> <dbl>
#  1     1  17.8  28.2  25.4
#  2     2  20.4  37.4  26.8
#  3     3  17.4  39.0  26.8
#  4     4  13.9  47.9  25.0
#  5     5  14.1  52.8  24.2
#  6     6  15.9  66.6  25.0
#  7     7  16.6  59.5  22.4
#  8     8  16.9  54.0  23.0
#  9     9  15.9  57.5  24.5
# 10    10  14.2  47.1  24.2
# 11    11  15.2  29.5  23.6
# 12    12  17.5  27.7  24.5

### once you learn the "dplyr" grammar there are a few additional benefits

        # dplyr can work with other data frames "backends"
        # data.table for large fast tables
        # SQL interface for relational databases via the DBI package

## Merging data

### merging data - merge()

setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Notes/Getting and cleaning data - week 3")

fileURL1 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/reviews.csv"
fileURL2 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/solutions.csv"
#### dropbox links are broken, so used the raw files in github
download.file(fileURL1, destfile="./data/reviews.csv", method = "curl")
download.file(fileURL2, destfile="./data/solutions.csv", method = "curl")

reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")

head(reviews,2)

#   id solution_id reviewer_id      start       stop time_left accept
# 1  1           3          27 1304095698 1304095758      1754      1
# 2  2           4          22 1304095188 1304095206      2306      1

head(solutions,2)

#   id problem_id subject_id      start       stop time_left answer
# 1  1        156         29 1304095119 1304095169      2343      B
# 2  2        269         25 1304095119 1304095183      2329      C

names(reviews)

# [1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept" 

names(solutions)

# [1] "id"         "problem_id" "subject_id" "start"      "stop"       "time_left"  "answer"  

mergedData = merge(reviews, solutions, by.x= "solution_id", by.y = "id", all = TRUE)
head(mergedData)

#   solution_id id reviewer_id    start.x     stop.x time_left.x accept problem_id subject_id    start.y     stop.y time_left.y answer
# 1           1  4          26 1304095267 1304095423        2089      1        156         29 1304095119 1304095169        2343      B
# 2           2  6          29 1304095471 1304095513        1999      1        269         25 1304095119 1304095183        2329      C
# 3           3  1          27 1304095698 1304095758        1754      1         34         22 1304095127 1304095146        2366      C
# 4           4  2          22 1304095188 1304095206        2306      1         19         23 1304095127 1304095150        2362      D
# 5           5  3          28 1304095276 1304095320        2192      1        605         26 1304095127 1304095167        2345      A
# 6           6 16          22 1304095303 1304095471        2041      1        384         27 1304095131 1304095270        2242      C

### Default - merge all common column names

intersect(names(solutions), names(reviews))

# [1] "id"        "start"     "stop"      "time_left"

mergedData2 = merge(reviews,solutions, all = TRUE)
head(mergedData2)

#   id      start       stop time_left solution_id reviewer_id accept problem_id subject_id answer
# 1  1 1304095119 1304095169      2343          NA          NA     NA        156         29      B
# 2  1 1304095698 1304095758      1754           3          27      1         NA         NA   <NA>
# 3  2 1304095119 1304095183      2329          NA          NA     NA        269         25      C
# 4  2 1304095188 1304095206      2306           4          22      1         NA         NA   <NA>
# 5  3 1304095127 1304095146      2366          NA          NA     NA         34         22      C
# 6  3 1304095276 1304095320      2192           5          28      1         NA         NA   <NA>

### using join in the plyr package

library(plyr)
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2),id)

#    id          x          y
# 1   1  1.0527557  0.1215197
# 2   2  1.0417257 -0.9334040
# 3   3 -1.1139813 -1.0304392
# 4   4  1.0950561  0.8006291
# 5   5 -2.8176594  2.5118577
# 6   6 -1.3289276  0.5181310
# 7   7 -0.4432149 -0.8902702
# 8   8  0.1454183  1.9837709
# 9   9 -0.4627339  0.2307731
# 10 10 -0.5034562 -1.1630135

### if you have multiple datasets

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
df3 = data.frame(id=sample(1:10), z=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)
