# Coursera: R Programming Simulation & Profiling
# Swirl lesson 1: Looking at data

#### setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Swirl/simulation, graphics, data")
#### write.csv(plants, "plants.csv")
#### set teh working directory and wrote plants.csv to work with swirl offline

## overview of the dataset 'plants'
ls()


class(plants)
dim(plants)
nrow(plants)
ncol(plants)
object.size(plants)

#preview of the dataset 'plants'

names(plants)
head(plants)
head(plants, 10)
tail(plants, 15)
summary(plants)

table(plants$Active_Growth_Period)
str(plants)

