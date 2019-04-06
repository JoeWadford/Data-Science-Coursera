### Coursera Data Science Specialization
## week 4: simulation and profiling
## swirl: base graphics

data(cars)

# exploring the cars dataset
?cars
head(cars)
dim(cars)
names(cars)
head(cars, 10)
tail(cars, 10)
summary(cars)

# plotting the dataset
plot(cars)
?plot
plot(x = cars$speed, y = cars$dist)
plot(x = cars$dist, y = cars$speed)

plot(x = cars$speed, y = cars$dist, xlab = "Speed")
plot(x = cars$speed, y = cars$dist, ylab = "Stopping Distance")
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
plot(cars, main = "My Plot")     
plot(cars, sub = "My Plot Subtitle")
plot(cars, col = 2)
plot(cars, xlim = c(10, 15))

?points
plot(cars, pch = 2)     

# graphics continued with mtcars data frame
data(mtcars)
play()
dim(mtcars)
names(mtcars)
head(mtcars, 10)
tail(mtcars, 10)
summary(mtcars)
nxt()

?boxplot
boxplot(formula = mpg ~ cyl, data = mtcars)
hist(mtcars$mpg)

