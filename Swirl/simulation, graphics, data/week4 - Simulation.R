### Coursera R Programming: Simulation and Profiling 
## Week 4: Simulation

#exploring the sample function
?sample
sample(1:6, 4, replace = TRUE)
sample(1:20, 10)

# exploring the LETTERS dataset using sample
LETTERS
sample(LETTERS)
sample()

# futher exploration of sample

flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips
sum(flips)

#intro to rbinom

?rbinom
rbinom(1, size = 100, prob = 0.7)

flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2
sum(flips2)

#intro to xnorm, xpois, etc

?rnorm
rnorm(10)
rnorm(10, mean = 100, sd = 25)

#rpois
?rpois
rpois(5, lambda = 10)

#replicating sampling multiple times
my_pois <- replicate(100, rpois(5, 10))
my_pois

cm <- colMeans(my_pois)
hist(cm)

