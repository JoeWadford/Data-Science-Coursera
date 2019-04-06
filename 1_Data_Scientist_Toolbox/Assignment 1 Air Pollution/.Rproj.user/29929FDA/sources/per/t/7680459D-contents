### Assignment 1: Air Pollution
## Coursera
## R Programming: Week 2 

setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata")

pollutantmean <- function(directory, pollutant, id = 1:332) {
        dfpollutant <- data.frame()
        files_list <- list.files(directory, full.names = TRUE)
        
        for (i in id) {
                dfpollutant <- rbind(dfpollutant, read.csv(files_list[i]))
        }
mean(dfpollutant[, pollutant], na.rm = TRUE)
               
}

pollutantmean("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", "sulfate", 1:10)

pollutantmean("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", "nitrate", 70:72)

pollutantmean("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", "sulfate", 34)

pollutantmean("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", "nitrate")

