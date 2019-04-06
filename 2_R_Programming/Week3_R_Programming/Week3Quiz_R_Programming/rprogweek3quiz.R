library(datasets)
data(iris)

?iris

mean(iris$Sepal.Length)

apply(iris[, 1:4], 2, mean)

data(mtcars)

head(mtcars)

lapply(mtcars, mean)

with(mtcars, tapply(mpg, cyl, mean))

split(mtcars, mtcars$cyl)


sapply(split(mtcars$mpg, mtcars$cyl), mean)


tapply(mtcars$mpg, mtcars$cyl, mean)

sapply(mtcars, cyl, mean)

apply(mtcars, 2, mean)

tapply(mtcars$cyl, mtcars$mpg, mean)

hpbycyl <- sapply(split(mtcars$hp, mtcars$cyl), mean)
hpbycyl

names(hpbycyl) <- c("fourcyl", "sixcyl", "eightcyl")     

hpbycyl <- as.numeric(hpbycyl)

abs(hpbycyl$fourcyl - hpbycyl$eightcyl)

mean(data$Temp[data$Month==6])