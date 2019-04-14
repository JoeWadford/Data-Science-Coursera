# Coursera Data Science Specialization
# text and date manipulation in R

## Editing text variables

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location.1" 

#### lower the case of the variable names
### fixing character vectors - tolower(), toupper()

tolower(names(cameraData))

# [1] "address"      "direction"    "street"       "crossstreet"  "intersection" "location.1" 

### fixing character vectors - strsplit()
#### good for automatically splitting variable names
#### important parameters: x, split

splitNames = strsplit(names(cameraData), "\\.")
splitNames[5]

# [1] "intersection"

splitNames[[6]]

# [1] "Location" "1"  

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)

# $letters
# [1] "A" "b" "c"

# $numbers
# [1] 1 2 3

# [[3]]
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    1    6   11   16   21
# [2,]    2    7   12   17   22
# [3,]    3    8   13   18   23
# [4,]    4    9   14   19   24
# [5,]    5   10   15   20   25

#### subset

mylist[1]

# $letters
# [1] "A" "b" "c"

#### sub-subset

mylist$letters
# [1] "A" "b" "c"

mylist[[1]]
# [1] "A" "b" "c"

### Fixing character vectors - sapply()
#### Applies a function to each element in a vector or list
#### Important parameters: X,FUN

splitNames[[6]][1]

# [1] "Location"

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location" 

#### loading the Peer Review Experiment Data

fileURL1 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/reviews.csv"
fileURL2 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/solutions.csv"
download.file(fileURL1,destfile="./data/reviews.csv",method="curl")
download.file(fileURL2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)

#   id solution_id reviewer_id      start       stop time_left accept
# 1  1           3          27 1304095698 1304095758      1754      1
# 2  2           4          22 1304095188 1304095206      2306      1

head(solutions, 2)

#   id problem_id subject_id      start       stop time_left answer
# 1  1        156         29 1304095119 1304095169      2343      B
# 2  2        269         25 1304095119 1304095183      2329      C

names(reviews)

# [1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept"   

#### Fixing character vectors - sub()
#### Important parameters: pattern, replacement, x
#### sub only replaces the first occurrence of the pattern specified, whereas gsub does it for all occurrences

names(reviews)

# [1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept"   

sub("_","",names(reviews),)

# [1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"   "accept" 

testName <- "this_is_a_test"
sub("_","",testName)

# [1] "thisis_a_test"

#### Fixing character vectors - gsub()
#### sub only replaces the first occurrence of the pattern specified, whereas gsub does it for all occurrences

gsub("_","",testName)

# [1] "thisisatest"

#### Finding values - grep(),grepl()
#### search for matches to argument pattern within each element of a character vector: 
#### they differ in the format of and amount of detail in the results.

grep("Alameda",cameraData$intersection)

# [1]  4  5 36

table(grepl("Alameda",cameraData$intersection))

# FALSE  TRUE 
#    77     3 

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
grep("Alameda",cameraData$intersection,value=TRUE)

# [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"

grep("JeffStreet",cameraData$intersection)

# integer(0)

length(grep("JeffStreet",cameraData$intersection))

# [1] 0

#### More useful string functions

library(stringr)
nchar("Jeffrey Leek")

# [1] 12

substr("Jeffrey Leek",1,7)

# [1] "Jeffrey"

paste("Jeffrey","Leek")

# [1] "Jeffrey Leek"
