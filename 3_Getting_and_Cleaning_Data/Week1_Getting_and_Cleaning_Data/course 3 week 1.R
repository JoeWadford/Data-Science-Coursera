# Coursera Data Science Specialization
## Course 3:  getting and cleaning data, week 1

## get/set your working directory: relative and absolute

### Relative
#### setwd("./data")
#### setwd("../")

### Absolute
setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Notes/Getting and Cleaning Data - week 1 notes")


## Checking for and creating directories

file.exists("directoryName")
#### False

dir.create("directoryName")

#### creates directory titled "directoryName"

if(!file.exists("data")) {
        dir.create("data")
}

#### since "data" did not exist, this function created a directory named "data" 

## Download a file from the web

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
#### [1] "cameras.csv"

## Reading local files

### reading tables
cameraData <- read.table("./data/cameras.csv", sep =",", header=T)
head(cameraData)

        #                address           direction      street  crossStreet               intersection
        # 1       S CATON AVE & BENSON AVE       N/B   Caton Ave   Benson Ave     Caton Ave & Benson Ave
        # 2       S CATON AVE & BENSON AVE       S/B   Caton Ave   Benson Ave     Caton Ave & Benson Ave
        # 3 WILKENS AVE & PINE HEIGHTS AVE       E/B Wilkens Ave Pine Heights Wilkens Ave & Pine Heights
        # 4        THE ALAMEDA & E 33RD ST       S/B The Alameda      33rd St     The Alameda  & 33rd St
        # 5        E 33RD ST & THE ALAMEDA       E/B      E 33rd  The Alameda      E 33rd  & The Alameda
        # 6        ERDMAN AVE & N MACON ST       E/B      Erdman     Macon St         Erdman  & Macon St
        
        # Location.1
        # 1 (39.2693779962, -76.6688185297)
        # 2 (39.2693157898, -76.6689698176)
        # 3  (39.2720252302, -76.676960806)
        # 4 (39.3285013141, -76.5953545714)
        # 5 (39.3283410623, -76.5953594625)
        # 6 (39.3068045671, -76.5593167803)

### reading csv files
cameraDataCsv <- read.csv("./data/cameras.csv") 
#### sep ="," and header =T are defaults
#### Other important parameters are quote, na.strings, nrows, skip

### reading excel files
library(xlsx)
cameraDataXL <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = T)

### Subsetting excel files
### the following examples subsets the cameras.xlsx file with the 2nd and 3rd columns and row 1-4
colIndex <- 2:3
rowIndex <- 1:4

cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, 
                              colIndex = colIndex, rowIndex = rowIndex)

cameraDataSubset
####   direction      street
#### 1       N/B   Caton Ave
#### 2       S/B   Caton Ave
#### 3       E/B Wilkens Ave

## Reading XML

library(XML)
library(httr)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- htmlParse(rawToChar(GET(fileUrl)$content))
rootNode <- xmlRoot(doc)
xmlName(rootNode)

#### [1] "html"

names(rootNode)
####  body
#### "body"

names(rootNode[[1]])
####  breakfast_menu
#### "breakfast_menu"

names(rootNode[[1]][[1]])
####   food   food   food   food   food 
####  "food" "food" "food" "food" "food" 

rootNode[[1]]
        # <body>
                # <breakfast_menu>
                        # <food>
                                # <name>Belgian Waffles</name>
                                # <price>$5.95</price>
                                # <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
                                # <calories>650</calories>
                        # </food>
                        # <food>
                                # <name>Strawberry Belgian Waffles</name>
                                # <price>$7.95</price>
                                # <description>Light Belgian waffles covered with strawberries and whipped cream</description>
                                # <calories>900</calories>
                        # </food>
                        # <food>
                                # <name>Berry-Berry Belgian Waffles</name>
                                # <price>$8.95</price>
                                # <description>Light Belgian waffles covered with an assortment of fresh berries and whipped cream</description>
                                # <calories>900</calories>
                        # </food>
                        # <food>
                                # <name>French Toast</name>
                                # <price>$4.50</price>
                                # <description>Thick slices made from our homemade sourdough bread</description>
                                # <calories>600</calories>
                        # </food>
                        # <food>
                                # <name>Homestyle Breakfast</name>
                                # <price>$6.95</price>
                                # <description>Two eggs, bacon or sausage, toast, and our ever-popular hash browns</description>
                                # <calories>950</calories>
                        # </food>
                # </breakfast_menu>
        # </body> 

rootNode[[1]][[1]]
        # <breakfast_menu>
                # <food>
                        # <name>Belgian Waffles</name>
                        # <price>$5.95</price>
                        # <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
                        # <calories>650</calories>
                # </food>
                # <food>
                        # <name>Strawberry Belgian Waffles</name>
                        # <price>$7.95</price>
                        # <description>Light Belgian waffles covered with strawberries and whipped cream</description>
                        # <calories>900</calories>
                # </food>
                # <food>
                        # <name>Berry-Berry Belgian Waffles</name>
                        # <price>$8.95</price>
                        # <description>Light Belgian waffles covered with an assortment of fresh berries and whipped cream</description>
                        # <calories>900</calories>
                # </food>
                # <food>
                        # <name>French Toast</name>
                        # <price>$4.50</price>
                        # <description>Thick slices made from our homemade sourdough bread</description>
                        # <calories>600</calories>
                # </food>
                # <food>
                        # <name>Homestyle Breakfast</name>
                        # <price>$6.95</price>
                        # <description>Two eggs, bacon or sausage, toast, and our ever-popular hash browns</description>
                        # <calories>950</calories>
                # </food>
        # </breakfast_menu> 

rootNode[[1]][[1]][[1]]
        # <food>
                # <name>Belgian Waffles</name>
                # <price>$5.95</price>
                # <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
                # <calories>650</calories>
        # </food> 

rootNode[[1]][[1]][[1]][[1]]
        # <name>Belgian Waffles</name>
        
### extracting parts of the file
xmlSApply(rootNode,xmlValue)

### getting names (in this instance menu items and prices) PROTIP: check underlying code
xpathSApply(rootNode, "//name", xmlValue)
        # [1] "Belgian Waffles"             "Strawberry Belgian Waffles"  "Berry-Berry Belgian Waffles"
        # [4] "French Toast"                "Homestyle Breakfast"

xpathSApply(rootNode, "//price", xmlValue)
        # [1] "$5.95" "$7.95" "$8.95" "$4.50" "$6.95"

### extracting content by attributes

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlParse(rawToChar(GET(fileUrl)$content))
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)
scores
        #  [1] "23-17" "47-3"  "34-23" "27-14" "26-14" "12-9"  "21-0"  "24-23" "36-21" "23-16" "24-21" "34-17" "26-16" "27-24"
        # [15] "20-12" "22-10" "26-24" "17-16" "33-7"  "20-19" "27-10" "30-20"

teams <- xpathSApply(doc, "//div[@class='game-info']", xmlValue)
teams
        #  [1] "vs  Chargers"   "vs  Bills"      "@  Bengals"     "vs  Broncos"    "@  Steelers"    "@  Browns"     
        # [7] "@  Titans"      "vs  Saints"     "@  Panthers"    "vs  Steelers"   "vs  Bengals"    "vs  Raiders"   
        # [13] "@  Falcons"     "@  Chiefs"      "vs  Buccaneers" "@  Chargers"    "vs  Browns"     "vs  Bears"     
        # [19] "vs  Rams"       "@  Colts"       "@  Dolphins"    "vs  Redskins"  

## Reading JSON 

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
        # [1] "id"                "node_id"           "name"              "full_name"         "private"          
        # [6] "owner"             "html_url"          "description"       "fork"              "url"              
        # [11] "forks_url"         "keys_url"          "collaborators_url" "teams_url"         "hooks_url"        
        # [16] "issue_events_url"  "events_url"        "assignees_url"     "branches_url"      "tags_url"         
        # [21] "blobs_url"         "git_tags_url"      "git_refs_url"      "trees_url"         "statuses_url"     
        # [26] "languages_url"     "stargazers_url"    "contributors_url"  "subscribers_url"   "subscription_url" 
        # [31] "commits_url"       "git_commits_url"   "comments_url"      "issue_comment_url" "contents_url"     
        # [36] "compare_url"       "merges_url"        "archive_url"       "downloads_url"     "issues_url"       
        # [41] "pulls_url"         "milestones_url"    "notifications_url" "labels_url"        "releases_url"     
        # [46] "deployments_url"   "created_at"        "updated_at"        "pushed_at"         "git_url"          
        # [51] "ssh_url"           "clone_url"         "svn_url"           "homepage"          "size"             
        # [56] "stargazers_count"  "watchers_count"    "language"          "has_issues"        "has_projects"     
        # [61] "has_downloads"     "has_wiki"          "has_pages"         "forks_count"       "mirror_url"       
        # [66] "archived"          "open_issues_count" "license"           "forks"             "open_issues"   
        # [71] "watchers"          "default_branch"  

names(jsonData$owner)
        # [1] "login"               "id"                  "node_id"             "avatar_url"          "gravatar_id"        
        # [6] "url"                 "html_url"            "followers_url"       "following_url"       "gists_url"          
        # [11] "starred_url"         "subscriptions_url"   "organizations_url"   "repos_url"           "events_url"         
        # [16] "received_events_url" "type"                "site_admin" 


jsonData$owner$login
        #  [1] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
        # [14] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
        # [27] "jtleek" "jtleek" "jtleek" "jtleek"

## writing data frames to JSON

myjson <- toJSON(iris, pretty=T)
cat(myjson)
        #   {
        # "Sepal.Length": 5,
        # "Sepal.Width": 3.4,
        # "Petal.Length": 1.5,
        # "Petal.Width": 0.2,
        # "Species": "setosa"
        # },
        # ...
        # ...
        # lots of groups later
        #   {
        # "Sepal.Length": 5,
        # "Sepal.Width": 3.4,
        # "Petal.Length": 1.5,
        # "Petal.Width": 0.2,
        # "Species": "setosa"
        # },

iris2 <- fromJSON(myjson)
head(iris2)
        #   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
        # 1          5.1         3.5          1.4         0.2  setosa
        # 2          4.9         3.0          1.4         0.2  setosa
        # 3          4.7         3.2          1.3         0.2  setosa
        # 4          4.6         3.1          1.5         0.2  setosa
        # 5          5.0         3.6          1.4         0.2  setosa
        # 6          5.4         3.9          1.7         0.4  setosa



# Week 1 Quiz

## Problem 1.  Download the 2006 microdata survey about housing for the state of Idaho
## using download.file.  How many properties are worth $1,000,000 or more?
install.packages("RCurl")
library("RCurl")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "2006 microdata survey.csv", "libcurl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf", "2006 microdata guidebook.pdf", mode = "wb")

mds06 <- read.csv("2006 microdata survey.csv")
dim(mds06)
#### [1] 6496  188

colnames(mds06)
        #   [1] "RT"       "SERIALNO" "DIVISION" "PUMA"     "REGION"   "ST"       "ADJUST"   "WGTP"     "NP"       "TYPE"    
        # [11] "ACR"      "AGS"      "BDS"      "BLD"      "BUS"      "CONP"     "ELEP"     "FS"       "FULP"     "GASP"    
        # [21] "HFL"      "INSP"     "KIT"      "MHP"      "MRGI"     "MRGP"     "MRGT"     "MRGX"     "PLM"      "RMS"     
        # [31] "RNTM"     "RNTP"     "SMP"      "TEL"      "TEN"      "VACS"     "VAL"      "VEH"      "WATP"     "YBL"     
        # [41] "FES"      "FINCP"    "FPARC"    "GRNTP"    "GRPIP"    "HHL"      "HHT"      "HINCP"    "HUGCL"    "HUPAC"   
        # [51] "HUPAOC"   "HUPARC"   "LNGI"     "MV"       "NOC"      "NPF"      "NPP"      "NR"       "NRC"      "OCPIP"   
        # [61] "PARTNER"  "PSF"      "R18"      "R60"      "R65"      "RESMODE"  "SMOCP"    "SMX"      "SRNT"     "SVAL"    
        # [71] "TAXP"     "WIF"      "WKEXREL"  "WORKSTAT" "FACRP"    "FAGSP"    "FBDSP"    "FBLDP"    "FBUSP"    "FCONP"   
        # [81] "FELEP"    "FFSP"     "FFULP"    "FGASP"    "FHFLP"    "FINSP"    "FKITP"    "FMHP"     "FMRGIP"   "FMRGP"   
        # [91] "FMRGTP"   "FMRGXP"   "FMVYP"    "FPLMP"    "FRMSP"    "FRNTMP"   "FRNTP"    "FSMP"     "FSMXHP"   "FSMXSP"  
        # [101] "FTAXP"    "FTELP"    "FTENP"    "FVACSP"   "FVALP"    "FVEHP"    "FWATP"    "FYBLP"    "wgtp1"    "wgtp2"   
        # [111] "wgtp3"    "wgtp4"    "wgtp5"    "wgtp6"    "wgtp7"    "wgtp8"    "wgtp9"    "wgtp10"   "wgtp11"   "wgtp12"  
        # [121] "wgtp13"   "wgtp14"   "wgtp15"   "wgtp16"   "wgtp17"   "wgtp18"   "wgtp19"   "wgtp20"   "wgtp21"   "wgtp22"  
        # [131] "wgtp23"   "wgtp24"   "wgtp25"   "wgtp26"   "wgtp27"   "wgtp28"   "wgtp29"   "wgtp30"   "wgtp31"   "wgtp32"  
        # [141] "wgtp33"   "wgtp34"   "wgtp35"   "wgtp36"   "wgtp37"   "wgtp38"   "wgtp39"   "wgtp40"   "wgtp41"   "wgtp42"  
        # [151] "wgtp43"   "wgtp44"   "wgtp45"   "wgtp46"   "wgtp47"   "wgtp48"   "wgtp49"   "wgtp50"   "wgtp51"   "wgtp52"  
        # [161] "wgtp53"   "wgtp54"   "wgtp55"   "wgtp56"   "wgtp57"   "wgtp58"   "wgtp59"   "wgtp60"   "wgtp61"   "wgtp62"  
        # [171] "wgtp63"   "wgtp64"   "wgtp65"   "wgtp66"   "wgtp67"   "wgtp68"   "wgtp69"   "wgtp70"   "wgtp71"   "wgtp72"  
        # [181] "wgtp73"   "wgtp74"   "wgtp75"   "wgtp76"   "wgtp77"   "wgtp78"   "wgtp79"   "wgtp80" 

rownames(mds06)
#### 1 - 10000

head(mds06)
#### lots of info

tail(mds06, 15)
#### lots more

valuecount <- table(mds06$VAL)
valuecount
#   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24 
# 75  42  33  30  26  29  23  70  99 119 152 199 233 495 483 486 357 502 232 312 164 159  47  53

## Problem 2.  Tidy Data Principles.  
### Tidy data has one variable per column

## Problem 3. Download excel file, read rows 18-23 and columns 7-15 and assign to variable "dat"
## what is the value of:  sum(dat$Zip*dat$Ext,na.rm=T)
install.packages("xlsx")
library("xlsx")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, 'Natural Gas Acquisition Program.xlsx', mode = "wb")
dat <- xlsx::read.xlsx(file = "Natural Gas Acquisition Program.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
#### [1] 36534720

## Problem 4.  read the XML data.  How many restaurants have zipcode 21231?
install.packages("XML")
library("XML")

fileUrl2 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
tempxml <- xmlInternalTreeParse(fileUrl2)
rootNode <- xmlRoot(tempxml)
names(rootNode)
####  row
#### "row"

names(rootNode[[1]][[1]])
####  name           zipcode      neighborhood   councildistrict    policedistrict        location_1 
#### "name"         "zipcode"    "neighborhood" "councildistrict"  "policedistrict"      "location_1" 

zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
table(zipcode==21231)
####  FALSE   TRUE
####  1200     127

## Problem 5.  Which will delivery the fastest user time.  3 options tied for fastest.  Tried each option until 
## I got the right answer
install.packages("data.table")
library("data.table")

fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl3, "American Community Survey.csv")
DT <- fread("American Community Survey.csv", sep = ",")


system.time(tapply(DT$pwgtp15,DT$SEX,mean))
#### user system elapsed
####  0     0       0


system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
#### Error: unexpected ';' in "system.time(mean(DT[DT$SEX==1,]$pwgtp15);"

system.time(mean(DT$pwgtp15,by=DT$SEX))      
#### user system elapsed
####  0     0       0

system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
#### Error: unexpected ';' in "system.time(rowMeans(DT)[DT$SEX==1];"

system.time(DT[,mean(pwgtp15),by=SEX])
####  user   system   elapsed
####  0.02    0.00     0.02

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#### user system elapsed
####  0     0       0


