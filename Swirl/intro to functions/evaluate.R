# You can pass functions as arguments to other functions just like you can pass
# data to functions. Let's say you define the following functions:

add_two_numbers <- function(num1, num2){
    num1 + num2
}

add_two_numbers(8, 9)
#### [1] 17

multiply_two_numbers <- function(num1, num2){
    num1 * num2
}

## some_function <- function(func){
##    func(2, 4)
## }

### As you can see we use the argument name "func" like a function inside of 
### "some_function()." By passing functions as arguments 
### some_function(add_two_numbers) will evaluate to 6, while
### some_function(multiply_two_numbers) will evaluate to 8.

## Function Assignment
### Finish the function definition below so that if a function is passed into the
### "func" argument and some data (like a vector) is passed into the dat argument
### the evaluate() function will return the result of dat being passed as an
### argument to func.

#### Hints: This exercise is a little tricky so I'll provide a few example of how
#### evaluate() should act:
####    1. evaluate(sum, c(2, 4, 6)) should evaluate to 12
####    2. evaluate(median, c(7, 40, 9)) should evaluate to 9
####    3. evaluate(floor, 11.1) should evaluate to 11

evaluate <- function(func, dat){
  x<- func(dat)
  x
}

evaluate(sum, c(2, 4, 6))
#### [1] 12

evaluate(median, c(7, 40, 9))
#### [1] 9

evaluate(floor, 11.1)
#### [1] 11

evaluate(sd, c(1.4, 3.6, 7.9, 8.8))
#### [1] 3.514138
