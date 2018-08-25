setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata")

complete <- function(directory, id = 1:332) {
        dfpollutant <- data.frame()
        nobs = rep(0, length(id))
        k <- 1
        
        for (i in id) {
                files_list <- list.files(directory, full.names = TRUE)
                dfp <- rbind(dfpollutant, read.csv(files_list[i]))
                
                nobs[k] <- sum(complete.cases(dfp))
                k <- k +1
               
                        }
        
        
        rk <- data.frame(id, nobs)
        rk
}

complete("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 10)

cc <- complete("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
