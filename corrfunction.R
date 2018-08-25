setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata")

corr  <- function(directory, threshold = 0) {
        
        
        dfpollutant <- c()
        files_list <- list.files(path = directory)
        
        for (i in 1:length(files_list)) {
                
                data <- read.csv( paste(directory, "/", files_list[i], sep=""))
                data <- data[complete.cases(data),]
                
                if (nrow(data) > threshold) {
                dfpollutant <- c(dfpollutant, cor(data$sulfate, data$nitrate) )   
                
                next
                
                }
        }
        return(dfpollutant)
}

cr <- corr("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata")
cr <- sort(cr)
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 129)
cr <- sort(cr)
n <- length(cr)
set.seed(197)
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 2000)
n <- length(cr)
cr <- corr("C:/Users/joewa/OneDrive/Desktop/Coursera/specdata", 1000)
cr <- sort(cr)
print(c(n, round(cr, 4)))

print(out)