R.Version()
library("RMySQL")

## Intro to RMySQL
# Databases -> tables within databases -> fields within tables

ucscDb <- dbConnect(MySQL(), user = "genome",
                    host = "genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb);
### [1] TRUE

result

## Connecting to database and listing tables

hg19 <- dbConnect(MySQL(), user= 'genome', db = 'hg19',
                  host = 'genome-mysql.cse.ucsc.edu')
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# getting dimensions of a specific table

dbListFields(hg19, "affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")

## reading from a table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## selecting a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10); dbClearResult(query);

dim(affyMisSmall)

## DON"T FORGET TO CLOSE THE CONNECTION!!

dbDisconnect(hg19)


### Coursera, Course 3: Getting and Cleaning Data
## Week 2, Reading from HDF5

source("http://bioconductor.org/biocLite.R")
biocLite('rhdf5')

## create groups 
library(rhdf5)
created = h5createFile('example.h5')
created = h5createGroup('example.h5', 'foo')
created = h5createGroup('example.h5', 'baa')
created = h5createGroup('example.h5', 'foo/foobaa')

h5ls('example.h5')

## Write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1,2.0, by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

## Write a dataset

df = data.frame(1L:5L, seq(0,1, length.out = 5),
                c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

## Reading Data

readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA

## Writing and reading Chunks

h5write(c(12, 13, 14), "example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")

### Coursera, Course 3: Getting and Cleaning Data
## Week 2, Reading from the Web

## Getting data off webpages - readLines()
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")

htmlCode = readLines(con)

close(con)
htmlCode

# output: "<!DOCTYPE html><html><head><title> Jeff Leek - Google Scholar Citations</title><meta name=\"robots...


## Parsing with XML

library(XML)
library(RCurl)

url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"

## due to errors, load library package RCurl and use getURL to fetch content
url1 <- getURL(url)
html <- htmlTreeParse(url1, useInternalNodes = T)

xpathSApply(html, "//title", xmlValue)

## always inspect the source material to find updates in the code
## previous slide read, "xpathSApply(html, "//td[@id='col-citedby']", xmlValue)" 
## which is not how the column "Cited By" is listed on the site anymore
xpathSApply(html, "//td[@class = 'gsc_a_c']", xmlValue)

## Get from the httr package

library(httr); html2 = GET(url)
content2 = content(html2, as='text')
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords

pg1 = GET("http://httppbin.org/basic-auth/user/passwd")
pg1

## information not accessible due to password requirements, use authenticate shown below

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2

names(pg2)

## Using handles

google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")

pg1
pg2

### Coursera, Course 3: Getting and Cleaning Data
## Week 2, Reading from APIs

#Reading the data from Twitter

myapp = oauth_app("twitter",
                  key ="yourConsumerKeyHere", secret = "yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

# Converting the json object

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

# Interacting more directly with files; remember to close connections
# file - open a connection to a text file
# url - open a connection to a url
# gzfile - open a connection to a .gz file
# bzfile - open a connection to a .bz2 file

#  foreign packages

# read.arff (Weka), read.dta (stata), read.mtp (minitab), read.octave (Octave), read.spss (SPSS), read.xport (SAS)

## Week 2 Quiz

# problem num 1.  Use the data to find the time that the datasharing repo was created

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "56b637a5baffac62cad9",
                   secret = "8e107541ae1791259e9987d544ca568633da2ebf")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/repos/jtleek/datasharing", gtoken)
stop_for_status(req)
content(req)

# answer Number 1.  2013-11-07T13:25:07Z

# Problem Num 2.  Which of the following commands will select only the data for the probability weights
# pswgtp1 with ages less than 50

library("sqldf")

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(URL, destfile = "./data.csv")
acs <- data.table::data.table(read.csv("data.csv", header=T))                     


sqldf("select pwgtp1 from acs where AGEP<50")

# answer sqldf("select pwgtp1 from acs where AGEP > 50")

# Problem Num 3. Using the same data frame you created in the previous problem, what is the 
# equivalent function to unique(acs$AGEP)

x <- unique(acs$AGEP)
y <- sqldf("select distinct pwgtp1 from acs")
a <- sqldf("select distinct AGEP from acs") 

a
y
x

## x and a are equivalent functions

# Problem Num 4. How many characters are in the 10th, 20th, 30th, and 100th

urlquiz <- "http://biostat.jhsph.edu/~jleek/contact.html"
urlquiz1 <- readLines(urlquiz)
urlqz1 <- getURL(urlquiz)
htmlquiz <- htmlTreeParse(urlquiz, useInternalNodes = T)

nchar(urlquiz1[10])
nchar(urlquiz1[20])
nchar(urlquiz1[30])
nchar(urlquiz1[100])
# 45, 31, 7, 25

# Problem 5. Read this dataset into R and report the sum of the numbers in the fourth of the nine cols

quiz5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
url5 <- read.fwf(quiz5, skip = 4, header = FALSE, widths=c(10, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4))
url5[,4]

sum(url5[,4])
