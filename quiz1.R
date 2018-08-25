setwd("C:/Users/joewa/OneDrive/Desktop/Coursera")
data<-read.csv("hw1_data.csv", header = TRUE, sep=",", na.strings="NA")

colnames(data)
nrow(data)
ncol(data)

q12 <- data[1:2,] 
print(q12)

q14 <- data[152:153,]
print(q14)

q15 <- data[47,1]
print(q15)

sum(is.na(data$Ozone))
mean(data$Ozone,na.rm=T)

q18 <- data[data$Ozone>31 & data$Temp>90,]
mean(data$Solar.R,na.rm=T)

mean(data$Temp[data$Month==6])
max(data$Ozone[data$Month==5],na.rm = T)


mean(data$Solar.R[data$Ozone>31 & data$Temp>90],na.rm = T)
