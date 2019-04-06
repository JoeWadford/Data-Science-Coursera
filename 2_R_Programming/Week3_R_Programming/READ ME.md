# Coursera Data Science Specialization, Course 2 week 3
# LOOP FUNCTIONS AND DEBUGGING

## LAPPLY

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
#### $a
#### [1] 3

#### $b
#### [1] 0.04060408

### reminder rnorm(n, mean = 0, sd = 1): used to generate n random numbers with arguments mean and sd


x <- 1:4
lapply(x, runif)
#### [[1]]
#### [1] 0.434829

#### [[2]]
#### [1] 0.697208923 0.003666458

#### [[3]]
#### [1] 0.92623540 0.06117778 0.76940754

#### [[4]]
#### [1] 0.3291578 0.5987924 0.5423560 0.5176269

### reminder runif(x, min =0, max = 1): provides information about the uniform distribution 
### on the interval from min to max. 
        dunif gives density
        punif gives the distribution function
        qunif gives the quantile function
        runif generates random deviates

## LAPPLY AND FRIENDS MAKE HEAVY USE OF ANONYMOUS FUNCTIONS
### LAPPLY(X, FUN, ...)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x 

#### $a
####       [,1] [,2]
#### [1,]    1    3
#### [2,]    2    4

#### $b
####       [,1] [,2]
#### [1,]    1    4
#### [2,]    2    5
#### [3,]    3    6

lapply(x, function(elt) elt[,1])
#### $a
#### [1] 1 2

#### $b
#### [1] 1 2 3


## SAPPLY a user-friendly version and wrapper of lapply by default returning 
### a vector, matrix or, if simplify = "array", an array if appropriate
### SAPPLY(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

#### $a
#### [1] 2.5

#### $b
#### [1] 0.3411735

#### $c
#### [1] 0.9151359

#### $d
#### [1] 4.949895

sapply(x, mean)
####         a         b         c         d 
#### 2.5000000 0.3411735 0.9151359 4.9498949 

mean(x)
#### Warning message:
#### In mean.default(x) : argument is not numeric or logical: returning NA


## APPLY Returns a vector or array or list of values obtained 
### by applying a function to margins of an array or matrix.
### APPLY(X, MARGIN, FUN, ...)

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
####  [1] -0.11436157 -0.12896039 -0.03370665 -0.33831858  0.25017026  0.29264073 -0.14548573 -0.25683556  0.02603712
#### [10]  0.41733255

apply(x, 1, sum)
####  [1] -0.6961460  0.4666120 -2.0360783  0.3452844 -1.5726572 -0.9003643 -1.4658392 -1.2582188  2.5019131  0.1110340
#### [11]  2.8216547  4.1300460  3.1364006 -1.3172053  3.9081753  2.6939380 -1.6089400  0.1531841 -4.9240087 -5.1185408

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))
####            [,1]       [,2]        [,3]       [,4]       [,5]       
#### 25% -0.04636229 -0.1899066 -0.01335986 -0.8763411 -0.8680308
#### 75%  0.48194023  0.8104544  1.24164605  0.3031794  1.4528135 
####            [,6]       [,7]        [,8]       [,9]      [,10]
####      -0.3703927 -0.7787102 -0.6269270  -0.6915739 -0.6009039
####       1.4702130  0.7462107  0.6166112   0.2395462  1.0271793
####           [,11]      [,12]       [,13]      [,14]      [,15] 
#### 25%  -0.4404616 -0.8967723  -1.356049  -0.8690445 -0.1031398
#### 75%   0.2833512  0.1727187   1.310303   0.1982973  0.5336147
####           [,16]      [,17]       [,18]      [,19]      [,20]
####     -0.81711920 -0.7602472 -0.1537149  -0.7088765 -1.2328561
####      0.02371946  0.1983185  0.3559867   0.2059894  0.2476141

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean)
####            [,1]       [,2]
#### [1,] -0.1271954  0.1119825
#### [2,]  0.2005199 -0.2526849

rowMeans(a, dims = 2)
####            [,1]       [,2]
#### [1,] -0.1271954  0.1119825
#### [2,]  0.2005199 -0.2526849


## MAPPLY is a multivariate version of sapply. 
### mapply applies FUN to the first elements of each ... argument, 
### the second elements, the third elements, and so on. Arguments are recycled if necessary.
### MAPPLY(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)

mapply(rep, 1:4, 4:1)
#### [[1]]
#### [1] 1 1 1 1

#### [[2]]
#### [1] 2 2 2

#### [[3]]
#### [1] 3 3

#### [[4]]
#### [1] 4

## MAPPLY: VeCTORIZING A FUNCTION

noise <- function(n, mean, sd)  {
        rnorm(n, mean, sd)
}

noise(5, 1, 2)
#### [1] -2.58601365 -0.05444133  1.70260905  1.79809213 -1.41280732

noise(1:5, 1:5, 2)
#### [1] -0.05510963  4.00757121  1.55715246 -1.59610118  0.50690776

mapply(noise, 1:5, 1:5, 2)
#### [[1]]
#### [1] -0.2620252

#### [[2]]
#### [1] 2.672481 5.138488

#### [[3]]
#### [1] -0.8201762  1.1932465  7.8973865

#### [[4]]
#### [1] 0.7717852 2.3485555 3.6783475 1.0426878

#### [[5]]
#### [1]  7.0080948  4.7327630  6.2191469  5.9270893 -0.4197542


## TAPPLY = Apply a function to each cell of a ragged array, that 
### is to each (non-empty) group of values given by a unique combination of the levels of certain factors.
### TAPPLY(X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f
####  [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
#### Levels: 1 2 3

tapply(x, f, mean)
####          1          2          3 
#### -0.1993099  0.4209278  0.7969944 

tapply(x, f, mean, simplify = FALSE)
#### $`1`
#### [1] -0.1993099

#### $`2`
#### [1] 0.4209278

#### $`3`
#### [1] 0.7969944

tapply(x, f, range)
#### $`1`
#### [1] -2.445399  1.760014

#### $`2`
#### [1] 0.00260103 0.87014622

#### $`3`
#### [1] 0.1781187 1.8484250

## SPLIT divides the data in the vector x into the groups defined by f. 
### The replacement forms replace values corresponding to such a division. 
### unsplit reverses the effect of split.
### SPLIT(x, f, drop = FALSE, ...)

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)
#### $`1`
#### [1] -0.06032431 -1.34667941 -1.52773252 -0.22382335 -1.01042800 -0.75412233 -0.82245824  1.16985429  0.32739380
#### [10] -1.39613308

#### $`2`
#### [1] 0.9059221 0.2826933 0.6940817 0.6572602 0.1604396 0.0323715 0.4770298 0.3367640 0.7011925 0.7445238

#### $`3`
#### [1] 1.617611796 1.760696410 1.215017957 0.008723078 1.909797186 0.997473057 0.959297711 0.279597448 1.599416561
#### [10] 1.602076731

lapply(split(x, f), mean)
#### $`1`
#### [1] -0.5644453

#### $`2`
#### [1] 0.4992279

#### $`3`
#### [1] 1.194971

head(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
#### $`5`
#### Ozone  Solar.R     Wind 
#### NA       NA 11.62258 

#### $`6`
#### Ozone   Solar.R      Wind 
#### NA 190.16667  10.26667 

#### $`7`
#### Ozone    Solar.R       Wind 
#### NA 216.483871   8.941935 

#### $`8`
#### Ozone  Solar.R     Wind 
#### NA       NA 8.793548 

#### $`9`
#### Ozone  Solar.R     Wind 
#### NA 167.4333  10.1800

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))
####                 5         6          7          8         9
#### Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
#### Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
#### Wind     11.62258  10.26667   8.941935   8.793548  10.18000    

x <- rnorm(10)
f1 <- gl(2, 5)       
f2 <- gl(5, 2)
f1
####  [1] 1 1 1 1 1 2 2 2 2 2
#### Levels: 1 2

f2
####  [1] 1 1 2 2 3 3 4 4 5 5
#### Levels: 1 2 3 4 5

interaction(f1, f2)
#### [1]     1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
#### Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5

str(split(x, list(f1, f2)))
#### Some interactions can create empty levels
#### List of 10
#### $ 1.1: num [1:2] -0.544 -0.709
#### $ 2.1: num(0) 
#### $ 1.2: num [1:2] -0.3639 0.0231
#### $ 2.2: num(0) 
#### $ 1.3: num -0.457
#### $ 2.3: num -0.448
#### $ 1.4: num(0) 
#### $ 2.4: num [1:2] 1.54 -0.38
#### $ 1.5: num(0) 
#### $ 2.5: num [1:2] 0.442 -0.507

split(x, list(f1, f2))
x
list(f1, f2)

str(split(x, list(f1, f2), drop = TRUE))
#### List of 6
####    $ 1.1: num [1:2] -0.544 -0.709
####    $ 1.2: num [1:2] -0.3639 0.0231
####    $ 1.3: num -0.457
####    $ 2.3: num -0.448
####    $ 2.4: num [1:2] 1.54 -0.38
####    $ 2.5: num [1:2] 0.442 -0.507

# DEBUGGING TOOLS - DIAGNOSING THE PROBLEM
## Example
printmessage2 <- function(x) {
        if(is.na(x))
                print("x is a missing value!")
        else if(x > 0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}
 
## MESSAGE - a generic notification/diagnostic message produced by the message function;
### execution of the function continues

## WARNING - an indication that something is wrong but not necessarily fatal; execution
### of the function continues; generated by the warning function

## ERROR - an indication that a fatal problem has occurred; execution stops; produced
### by the stop function

## CONDITION - a generic conept for indicating that something unexpected can occur;
### programmers can create their own conditions

x <- log(-1)
#### Warning message:
#### In log(-1) : NaNs produced
#### printmessage2(x)
#### [1] "x is a missing value!"
 
## DEBUGGING TOOLS - BASIC TOOLS
 
## TRACEBACK - prints out the function call stack after an error occurs; 
### does nothing if there's no error
 
## DEBUG - flags a function for "debug" mode which allows you to step through execution 
### of a function one line at a time
 
## BROWSER - suspends the execution of a function wherever it is called and puts the 
### function in debug mode
 
## TRACE - allows you to insert debugging code into a function at specific places
 
## RECOVER - allows you to modify the error behavior so that you can browse the function
### call stack
 

 
# WEEK 3 QUIZ
 
library(datasets)
data(iris) 
?iris

## QUESTION 1.  WHAT IS THE MEAN OF SEPAL.LENGTH FOR THE SPECIES VIRGINICA?
mean(iris$Sepal.Length[iris$Species == "virginica"])
#### 6.588

## QUESTION 2.  WHAT R CODE RETURNS A VECTOR OF THE MEANS OF THE VARIABLES "SEPAL.LENGTH," "SEPAL.WIDTH,"
## "PETAL.LENGTH," and "PETAL.WIDTH."

apply(iris[, 1:4], 1, mean)
#### Wrong.  returns means of the rows 
rowMeans(iris[, 1:4])
#### wrong. returns means of the rows
apply(iris[, 1:4],2,mean)
#### CORRECT.  returns means of the columns
apply(iris, 1, mean)
#### returns NAs
colMeans(iris)
#### Error in colMeans(iris) : 'x' must be numeric
apply(iris, 2, mean)
#### In mean.default(newX[, i], xxx) :
#### argument is not numeric or logical: returning NA

## QUESTION 3. LOAD THE MTCARS DATASET IN R WIITH THE FOLLOWING CODE
library(datasets)
data(mtcars)
## HOW CAN ONE CALCULATE THE AVG MILES PER GALLON (MPG) BY NUMBER OF CYLINDERS IN THE CAR (CYL)?  

lapply(mtcars, mean)
#### the mean of each individual column

with(mtcars, tapply(mpg, cyl, mean))
#### CORRECT. yields the average miles per gallon by number of cylinders in the car

mean(mtcars$mpg, mtcars$cyl)
#### Error in mean.default(mtcars$mpg, mtcars$cyl) :
#### 'trim' must be numeric of length one

split(mtcars, mtcars$cyl)
#### split by cyl but also includes a complete summary per car

sapply(split(mtcars$mpg, mtcars$cyl), mean)
#### CORRECT. yields the average miles per gallon by number of cylinders in the car

tapply(mtcars$mpg, mtcars$cyl, mean)
#### CORRECT. yields the average miles per gallon by number of cylinders in the car

sapply(mtcars, cyl, mean)
####Error in match.fun(FUN) : object 'cyl' not found

apply(mtcars, 2, mean)
#### yields the average of each column

tapply(mtcars$cyl, mtcars$mpg, mean)


## QUESTION 4. WHAT IS THE ABSOLUTE DIFFERENCE BETWEEN THE AVERAGE HORSEPOWER OF 4-CYLINDER CARS
## AND THE AVERAGE OF 8-CYLINDER CARS?

mean(mtcars$hp[mtcars$cyl == 8]) - mean(mtcars$hp[mtcars$cyl == 4])
#### 126.5779

## QUESTION 5.  IF YOU RUN debug(ls) WHAT HAPPENS WHEN YOU NEXT CALL THE 'LS' FUNCTION?
debug(ls)
ls(mtcars)
#### Execution of the 'ls' will suspend at the beginning of the function and you will be in 
#### the browser
