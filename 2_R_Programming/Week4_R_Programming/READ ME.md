# Coursera Course: R Programming - Week 4
# Simulation and Profiling

## str function:  compactly display the internal structure of an R object
### a diagnostic function and an alternative to 'summary'
### it is especially well suited to compactly  display the contents of lists
### roughly one line per basic object

str(lm)
#### function (formula, data, subset, weights, na.action, method = "qr", model = TRUE, x = FALSE, y = FALSE, qr = TRUE, 
#### singular.ok = TRUE, contrasts = NULL, offset, ...)  

str(ls)
#### function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, pattern, sorted = TRUE) 

x <- rnorm(100, 2, 4)
summary(x)
####     Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#### -10.193  -1.120   1.863   1.802   4.217  12.317 

str(x)
#### num [1:100] 0.565 5.266 0.203 0.274 2.633 ...

f <- gl(40, 10)
str(f)
#### Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...

summary(f)
####  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 
#### 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 

library(datasets)
head(airquality)
str(airquality)

m <- matrix(rnorm(100), 10, 10)
str(m)
####  num [1:10, 1:10] 1.38 0.274 -1.113 0.23 -2.835 ...
m[, 1]
#### [1]  1.3804714  0.2740374 -1.1125282  0.2296209 -2.8347922  1.5420192  1.2769432  1.0989810 -0.9926823 -0.8901688

s <- split(airquality, airquality$Month)
str(s)


## GENERATING RANDOM NUMBERS

### rnorm: generate random Normal variates with a given mean and standard deviation
### dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)
### pnorm: evaluate the cumulative distribution function for a Normal distribution
### rpois: generate random Poisson variates with a given rate

## probablity distribution functions typically have four functions associated with them.  
### the functions are prefixed with a 
        d for density
        r for random number generation
        p for cumulative distribution
        q for quantile function

## Cumulative Distribution / Poisson Distribution
ppois(2, 2)  
#### [1] 0.6766764 Pr(x <= 2) when rate/mean is 2

ppois(4, 2) 
#### [1] 0.947347 Pr(x <= 4)

ppois(6, 2)
#### [1] 0.9954662 Pr(x <= 6)

### set.seed() ensures reproducibility 


## SIMULATING A LINEAR MODEL

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e

summary(y)
####    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#### -6.4084 -1.5402  0.6789  0.6893  2.9303  6.5052 

plot(x, y)

## BINOMIAL PLOT
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0 , 2)
y <- 0.5 + 2 * x + e

summary(y)
####    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#### -3.4936 -0.1409  1.5767  1.4322  2.8397  6.9410 

plot(x, y)

## POISSON DISTRIBUTION

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
####    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
####    0.00    1.00    1.00    1.55    2.00    6.00 

plot(x, y)

## RANDOM SAMPLING

set.seed(1)
sample(1:10, 4)
#### [1] 3 4 5 7
sample(1:10, 4)
#### [1] 3 9 8 5
sample(letters, 5)
#### [1] "q" "b" "e" "x" "p"
sample(1:10)
#### [1]  4  7 10  6  9  2  8  3  1  5
sample(1:10, replace = TRUE)  #sample with replacement
#### [1] 2 3 4 1 4 9 4 5 6 5

## SIMULATION SUMMARY
### Drawing samples from specific probablity distributions can be done with r* functions
### Standard distributions are built in: Normal, Poisson, Binomial, Exponential, Gamma, etc.
### The sample function can be used to draw random samples from arbitrary vectors
### Setting the random number generator seed via set.seed is critical for reproducibility


## R PROFILER

## Design Optimization
        step 1 = design first, then optimize
        step 2 = premature optimization is the root of all evil
        step 3 = measure data, don't guess

## USING SYSTEM.TIME() = takes an arbitrary R expression as input (can be wrapped in curly braces)
## and return the amount of time taken to evaluate the expression

### user.time = time charged to the CPU(s) for this expression
### elapsed.time = "wall clock" time

### elapsed time may be greater than user time if the CPU spends a lot of time waiting around
### elapsed time may be smaller than the user time if your machine has multiple cores/processors and 
### is capable of using them

system.time(readLines("http://www.jhsph.edu"))
####    user  system elapsed 
####    0.16    0.02    1.19 

hilbert <- function(n) {
        i <- 1:n
        1 / outer(i - 1, i, "+")
}

x <- hilbert(1000)
system.time(svd(x))
####    user  system elapsed 
####    2.70    0.00    3.22 


## THE R PROFILER
### The Rprof() function starts the profiler in R; keeps track of the function call stack at 
### regularly sampled intervals and tabulates how much time is spend in each function
        
### summaryRprof() function summarizes the output from Rprof(); tabulates the R profiler output
### and calculates how much time is spent in which function
        ### two methods for normalizing the data
                ### "by.total" divides the time spend in each function by the total run time
                ### "by.self" does the same but first subtracts out time spent in functions above 
                ### in the call stack

## DO NOT use system.time() and Rprof() together or you will be sad


# QUIZ $: WEEK 4 - R PROGRAMMING

## QUESTION 1 - What is produced at the end of this snippet of R code?
set.seed(1)
rpois(5, 2)
### [1] 1 1 2 4 1

## QUESTION 2 - What R function can be used to generate standard Normal random variables?
### rnorm - Functions beginnning with the 'r' prefix are used to simulate random variates

## QUESTION 3 - When simulating data, why is using the set.seed() function important?
### it ensure that the sequence of random numbers start in a specific place and is
### therefore reproducible

## QUESTION 4 - WHICH FUNCTION CAN BE USED TO EVALUATE THE INVERSE CUMULATIVE DISTRIBUTION
## FUNCTION FOR THE POISSON DISTRIBUTION?
### dpois - Functions beginning with the 'd' prefix are used to genearte density or distribution functions

## QUESTION 5 - WHAT DOES THE FOLLOWING CODE DO?
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
### Generate data from a Normal linear model

## QUESTION 6 - WHAT R FUNCTION CAN BE USED TO GENERATE BINOMIAL RANDOM VARIABLES?
### rbinom

## QUESTION 7 - WHAT ASPECT OF THE R RUNTIME DOES THE PROFILER KEEP TRACK OF WHEN AN R 
## EXPRESSION IS EVALUATED?
### the function call stack

## QUESTION 8 - CONSIDER THE FOLLOWING R CODE?
library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
## ASSUME THAT Y, X1, AND X2 ARE PRESENT IN THE WORKSPACE.  WITHOUT RUNNING THE CODE, WHAT %
## OF THE RUN TIME IS SPENT IN THE 'LM' FUNCTION, BASED ON THE 'BY.TOTAL' METHOD OF 
## NORMALIZATION SHOWN IN 'SUMMARYRPROF()'?

### 100%.  When using 'by.total' normalization, the top-level function (in this case, 'lm()') always
### takes 100% of the time.


## QUESTION 9 - When using 'system.time()', what is the user time?
### It is the time spent by the CPU evaluating an expression

## QUESTION 10 - IF A COMPUTER HAS MORE THAN ONE AVAILABLE PROCESSOR AND R IS ABLE TO TAKE 
## ADVANTAGE OF THAT, THEN WHICH OF THE FOLLOWING IS TRUE WHEN USING 'SYSTEM.TIME()'?
### elapsed time may be smaller than user time