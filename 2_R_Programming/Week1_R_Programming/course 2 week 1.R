### Coursera Data Science, Course 2 week 1
### R Programming

## EXPLICIT COERCISION

x <- 0:6
class(x)
# integer

as.numeric(x)
# [1] 0 1 2 3 4 5 6

as.logical(x)
# [1] FALSE TRUE TRUE TRUE TRUE TRUE TRUE

as.character(x)
# [1] "0" "1" "2" "3" "4" "5" "6"

## LISTS

x <- list(1, "a", TRUE, 1 + 4i)
x

## MATRICES

m <- matrix(1:6, nrow = 2, ncol = 3)
m

dim(m) 

attributes(m)

m1 <- 1:10
m1

dim(m1) <- c(2, 5)
m1

# cbind-ing and rbind-ing

x <- 1:3
y <- 10:12

cbind(x, y)
rbind(x, y)


## FACTORS

x <- factor(c("yes", "yes", "no", "yes", "no"))
x

table(x)

unclass(x)
attr(x,"levels")

## DATA FRAMES

xdf <- data.frame(foo =  1:4, bar = c(T, T, F, F))
xdf

nrow(xdf)
ncol(xdf)

## NAMES

x <- 1:3
names(x)

names(x) <- c("foo", "bar", "norf")
x
names(x)

x <- list(a =1, b =2, c=3)
x

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m                    

## TEXTUAL DATA FORMATS

y <- data.frame(a=1, b="a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y

# Dumping R Objects

x <- "foo"
y <- data.frame(a=1, b="a")
dump(c("x", "y"), file = "data.R")
rm(x,y)
source("data.R")
y
x

## CONNECTIONS: INTERFACES TO THE OUTSIDE WORLD

str(file)
function (description = "", open = "", blocking = TRUE,
          encoding = getOption("encoding"))
        
# Reading Lines of a Text File

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)

## SUBSETTING BASICS

x <- c("a", "b", "c", "c", "d", "a")

x[1]
# [1] "a"

x[2]
# [1] "b"

x[1:4]
# [1] "a" "b" "c" "c"

x[x > "a"]
# [1] "b" "c" "c" "d"

u <- x > "a"
u
# [1] FALSE TRUE TRUE TRUE TRUE FALSE

x[u]
# [1] "b" "c" "c" "d"


## SUBSETTING LISTS

x <- list(foo = 1:4, bar = 0.6)
x[1]
# $foo
# [1] 1 2 3 4

x[[1]]
# [1] 1 2 3 4

x$bar
# [1] 0.6

x[["bar"]]
# [1] 0.6

x["bar"]
# $bar
# [1] 0.6

x1 <- list(foo = 1:4, bar = 0.6, baz = "hello")
x1[c(1,3)]
# $foo
# [1] 1 2 3 4

# $baz
# [1] "hello"

x2 <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"

x[[name]]
# [1] 1 2 3 4

x$name
# NULL

x$foo
# [1] 1 2 3 4

x3 <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x3[[c(1,3)]]
#[1] 14

x3[[1]][[3]]
# [1] 14

x3[[c(2, 1)]]
# [1] 3.14

## SUBSETTING A MATRIX

mx <- matrix(1:6, 2, 3)
mx[1,2]
# [1] 3

mx[2,1]
# [1] 2

mx[1,]
# [1] 1 3 5

mx[,2]
# [1] 3 4

mx[1,2, drop = FALSE]
#       [,1]
# [1,]   3

mx[1, ,drop = FALSE]
#        [,1]  [,2]  [,3]
#  [1,]   1     3     5

## PARTIAL MATCHING

px <- list(aardvark = 1:5)
px$a
# [1] 1 2 3 4 5

px[["a"]]
# NULL, because a does not equal aardvark exactly

px[["a", exact = FALSE]]
# [1] 1 2 3 4 5

## REMOVING NA Values

nax <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(nax)
nax[!bad]
#[1] 1 2 4 5

nay <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(nax, nay)
good
# TRUE TRUE FALSE TRUE FALSE TRUE

nax[good]
# [1] 1 2 4 5

nay[good]
# [1] "a" "b" "d" "f"

airquality[1:6,]
# Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6

goodaq <- complete.cases(airquality)
airquality[goodaq,][1:6,]
Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 7    23     299  8.6   65     5   7
# 8    19      99 13.8   59     5   8

## VECTORIZED OPERATIONS

vox <- 1:4; voy <- 6:9
vox + voy
# [1] 7 9 11 13

vox > 2
# [1] FALSE FALSE TRUE TRUE

vox >= 2 
#[1] FALSE TRUE TRUE TRUE

voy == 8 
# [1] FALSE FALSE TRUE FALSE

vox * voy
# [1] 6 14 24 36

round(vox / voy, 2)
# [1] 0.17 0.29 0.38 0.44

# Vectorized Matrix Operations

vmox <- matrix(1:4, 2, 2); vmoy <- matrix(rep(10, 4), 2, 2)
vmox
#       [,1]  [,2]
# [1,]   1      3
# [2,]   2      4

vmoy
#       [,1]  [,2]
# [1,]   10    10
# [2,]   10    10

vmox * vmoy
#       [,1]  [,2]
# [1,]   10    30
# [2,]   20    40

round(vmox/vmoy, 2)
#       [,1]   [,2]
# [1,]   0.1   0.3
# [2,]   0.2   0.4

vmox %*% vmoy # True matrix multiplication
#       [,1]  [,2]
# [1,]   40    40
# [2,]   60    60

### WEEK 1 QUIZ

# Problems involving code are included for my practice purposes only.  Please do not use this to cheat!

## PROBLEM 4.  What is the class of x4?

x4 <- 4
class(x4)
# numeric

## PROBLEM 5.  

x5 <- c(4, "a", TRUE)
class(x5)
# Character

## PROBLEM 6.  What is produced by the expression rbind(x, y)?

x6 <- c(1,3,5); y6 <- c(3,2,10)
rbind(x6, y6)

# a matrix with two rows and 3 columns
#       [,1] [,2] [,3]
#  x6    1    3    5
#  y6    3    2   10

## PROBLEM 8.  What does x8[[2]] give me?

x8 <- list(2, "a", "b", TRUE)
x8[[2]]
# [1] "a"
# a character vector containing the letter "a"
# a character vector of length 1

## PROBLEM 9.  What is produced by the expression x9 + y9?

x9 <- 1:4; y9 <- 2:3
z9 <- x9 + y9
class(z9)
# [1] 3 5 5 7
# an integer vector with the values 3, 5, 5, and 7

## PROBLEM 10.  What R code causes a vector with all its elements greater than 10 to be equal to 4?

x10 <- c(17, 14, 4, 5, 13, 12, 10)
# x10[x10 > 10] <- 4
# x10[x10 >= 11] <- 4


## PROBLEM 11. What are the column names?

quiz1 <- read.csv("hw1_data.csv")

colnames(quiz1)
# [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"  

## PROBLEM 12. Extract the first two rows fo the data frame and print them to the console.

head(quiz1, 2)
#     Ozone Solar.R Wind Temp Month Day
#  1    41     190  7.4   67     5   1
#  2    36     118  8.0   72     5   2

## PROBLEM 13.  How many observations are in this data frame?

nrow(quiz1)
# 153


## PROBLEM 14.  Extract the last 2 rows of the data frame and print them to the console.

tail(quiz1, 2)
#       Ozone Solar.R Wind Temp Month Day
#  152    18     131  8.0   76     9  29
#  153    20     223 11.5   68     9  30

## PROBLEM 15.  What is the value of the Ozone in the 47th row?

quiz1[47, "Ozone"]
# [1] 21


## PROBLEM 16. How many missing values are in the Ozone column of this data frame?

sum(is.na(quiz1$Ozone))
# [1] 37


## PROBLEM 17.  What is the mean of the Ozone column in this dataset?  Exclude missing values

mean(quiz1$Ozone, na.rm = TRUE)
# [1] 42.12931


## PROBLEM 18.  
mean(quiz1$Solar.R[quiz1$Ozone > 31 & quiz1$Temp > 90], na.rm = TRUE)
# [1] 212.8


## PROBLEM 19.  What is the mean of Temp when the month is equal to 6?
mean(quiz1$Temp[quiz1$Month==6], na.rm=T)
#[1] 79.1

## PROBLEM 20.  What was the maximum ozone value in the month of May?
max(quiz1$Ozone[quiz1$Month==5], na.rm=T)
#[1] 115