# COURSERA COURSE 2 R PROGRAMMING, WEEK 2
## PROGRAMMING WITH R

## IF STATEMENTS

x<- 1:5
if (x > 3) {
        y <- 10
}  else {
        y <- 0
}
y
####[1] 0

x <- 4

y <- if(x>3) {
        10
} else {
        0
}

y
#### [1] 10


## FOR STATEMENTS

for(i in 1:10) {
        print(i)
}

x <- c("a", "b", "c", "d")

for(i in 1:4) {
        print(x[i])
}

for(i in seq_along(x)) {
        print(x[i])
}

for(letter in x)  {
        print(letter)
}

for(i in 1:4) print(x[i])

## Nested FOR Loops

x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x)))  {
        for(j in seq_len(ncol(x)))  {
                print(x[i, j])
        }
}


## WHILE STATEMENTS

count <- 0

while(count < 10) {
        print(count)
        count <- count + 1
}

z <- 5

while(z >= 3 && z <= 10) {
        print(z)
        coin <- rbinom(1, 1, 0.5)
        
        if(coin == 1) { ## random walk
                z <- z + 1
        } else {
                z <- z- 1
        }
}

## CONTROL STRUCTURES - REPEAT
### repeat initiates an infinite loop.  Only way to exit a repeat loop is to call break

x0 <- 1 
tol <- 1e-8

repeat { 
        x1 <- computeEstimate()
        
        if(abs(x1 - x0) < tol){
                break
        } else {
                x0 <- x1
        }
}

## CONTROL STRUCTURES - NEXT

for(i in 1:100) {
        if(i <= 20) {
                ## skip the first 20 iterations
                next
        }
        ## DO something here
}

## YOUR FIRST FUNCTION

add2 <- function(x, y) {
        x + y
}

add2(3, 5)
#### [1] 8

above10 <- function(x) {
        use <- x > 10
        x[use]
}

above <- function(x, n) {
        use <- x > n
        x[use]
}
x <- 1:20
above(x, 12)
#### [1] 13 14 15 16 17 18 19 20 


columnmean <- function(y, removeNA = TRUE) {
        nc <- ncol(y)
        means <- numeric(nc)
        for(i in 1:nc) {
                means[i] <- mean(y[,i], na.rm = removeNA)
        }
        means
}

columnmean(airquality)
#### [1] 42.129310 185.931507 9.957516  77.882353   6.993464  15.803922
columnmean(airquality, FALSE)
#### [1] NA        NA  9.957516 77.882353  6.993464 15.803922

## FUNCTIONS CONTINUED

## Argument Matching

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)

args(lm)

### the following two functions are equivalent

lm(data = mydata, y ~ x, model = FALSE, 1:100)
lm(y ~ x, mydata, 1:100, model = FALSE)

## Defining a function

f <- function(a, b){
        a^2
}
f(2)
#### [1] 4, (b never gets used so calling the function of 2 gives us 4)

f <- function(a,b) {
        print(a)
        print(b)
}
f(45)        
#### [1] 45
#### Error in print(b) : argument "b" is missing, with no default

### notice that R prints(a) but then tries to call (b) and then prints the error

##  The "..." Argument

myplot <- function(x, y, type = "l", ...) {
        plot(x, y, type = type, ...)
}

mean

#### function (x, ...) 
#### UseMethod("mean")
#### <bytecode: 0x000000000e699c48>
#### <environment: namespace:base>

args(paste)
#### function (..., sep = " ", collapse = NULL) 
#### NULL

paste("a", "b", sep = ":")
#### [1] "a:b"

paste("a", "b", se = ":")
#### [1] "a b :"

## A diversion on binding values to symbol

lm <- function(x) {x * x}
lm

## SCOPING RULES
### Lexical scoping = the values of the free variables are searched for inthe environment in which the function
### was defined

f <- function(x, y) {
        x^2 + y/z
}

#### in the above example "z" is the free variables

make.power <- function(n)  {
        pow <- function(x) {
                x ^ n
        }
        pow
}

cube <- make.power(3)
square <- make.power(2)

cube(3)
#### [1] 27
square(3)
#### [1] 9  

ls(environment(cube))
#### [1] "n" "pow"

get("n", environment(cube))
#### [1] 3

ls(environment(square))
#### "n" "pow"

get("n", environment(square))
#### [1] 2

## Lexical vs Dynamic Scoping

y <- 10
f<- function(x) {
        y <- 2
        y^2 + g(x)
}

g <- function(x) {
        x*y
}

f(3)
#### [1] 34

g <- function(x) {
        a <- 3
        x+a+y
}

y<- 3
g(2)
#### [1] 8

## SCOPING RULES OPTIMIZATION

make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) {
        params <- fixed
        function(p)  {
                params[!fixed] <- p
                mu <- params[1]
                sigma <- params[2]
                a <- -0.5*length(data)* log(2*pi*sigma^2)
                b <- -0.5*sum((data-mu)^2) / (sigma^2)
                -(a+b)
        }
}

set.seed(1); normals <- rnorm(100,1,2)
nll <- make.NegLogLik(normals)
nll
ls(environment(nll))

#### [1] "data" "fixed" "params"

optim(c(mu = 0, sigma = 1), nll)$par
####        mu       sigma
####     1.218239  1.787343

nll <- make.NegLogLik(normals, c(FALSE,2))
optimize(nll, c(-1, 3))$minimum
#### [1] 1.217775

nll <- make.NegLogLik(normals, c(1, FALSE))
optimize(nll, c(1e-6, 10))$minimum
#### [1] 1.800596

nll <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nll)
plot(x, exp(-(y-min(y))), type = "l")

nll <- make.NegLogLik(normals,c(FALSE, 2))
x  <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nll)
plot(x, exp(-(y-min(y))), type = "l")


## CODING STANDARDS FOR R

### 1. Always use text files / text editor
### 2. Indent your code
### 3. Limit the width of your code (80 columns?)
### 4. Limit the length of individual functions

## DATES AND TIMES

x <- as.Date("1970-01-01")
x
#### [1] "1970-01-01"

unclass(x)
#### [1] 0

unclass(as.Date("1970-01-01"))
#### [1] 0

x <- Sys.time()
x
#### [1] "2018-12-02 19:45:48 EST"

p <- as.POSIXlt(x)
names(unclass(p))

#### [1] "sec"    "min"    "hour"   "mday"   "mon" 
#### [6]  "year"   "wday"   "yday"   "isdst"  "zone"   "gmtoff"

p$sec
#### [1] 48.53246

unclass(x)
#### 1543797949

x$sec
#### Error in x$sec : $ operator is invalid for atomic vectors

p$sec
#### [1] 48.53246

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
#### [1] "2012-01-10 10:40:00 EST" "2011-12-09 09:10:00 EST"

class(x)
#### [1] "POSIXlt" "POSIXt"

x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")
x - y
#### [1] Time difference of 2 days

# WEEK 2 QUIZ

## PROBLEM 1.  What is the result of running?

cube <- function(x, n) {
        x^3
}
cube(3)
#### [1] 27
#### "n" is not evaluated, it is not needed even though it is a formal argument

## PROBLEM 2. The following code will produce a warning in R.  Why?

x <- 1:10
if(x >5)  {
        x <- 0
}

#### Warning message: the condition has length > 1 and only the first element will be used


## PROBLEM 3. What value is returned?

f <- function(x)  {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}

z <- 10
f(3)
#### [1] 10


## PROBLEM 4. What is the value of "y" after evaluating this expression?

x <- 5
y <- if(x < 3) {
        NA
}       else {
        10
}
y
#### [1] 10


## PROBLEM 5.  which symbol in the below function is a free variable?

h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}
#### f is the free variable


## PROBLEM 6.  What is an environment in R?
#### a collection of symbol/value pairs


## PROBLEM 7.  The R language  uses what type of scoping rule for resolving free variables?
#### lexical scoping

## Problem 8. How are free variables in R functions resolved?
#### The values of free variables are searched for in the environment in which the
#### function was defined. 

## PROBLEM 9.  What is one of the consequences of the scoping rules used in R?
#### All objects must be storedin memory

## PROBLEM 10.  In R, what is the parent frame?
#### It is the environment in which a function was called