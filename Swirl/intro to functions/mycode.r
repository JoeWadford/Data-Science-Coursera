setwd("C:/Users/joewa/OneDrive/Desktop/Coursera")


myfunction <- function() {
  x <- rnorm(100)
  mean(x)
}


second <- function(x) {
  x + rnorm(length(x))
}

