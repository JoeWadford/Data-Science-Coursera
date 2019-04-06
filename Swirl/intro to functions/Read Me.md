# First Function
# You're about to write your first function! Just like you would assign a value 
# to a variable with the assignment operator, you assign functions in the following way:

### function_name <- function(arg1, arg2){
### Manipulate arguments in some way
### Return a value
### }

### The "variable name" you assign will become the name of your function. arg1 and
### arg2 represent the arguments of your function. You can manipulate the arguments
### you specify within the function. After sourcing the function, you can use the 
### function by typing:

### function_name(value1, value2)

### Below we will create a function called boring_function. This function takes
### the argument `x` as input, and returns the value of x without modifying it.
### Delete the pound sign in front of the x to make the function work! Be sure to 
### save this script and type submit() in the console after you make your changes.

boring_function <- function(x) {
  x
}
boring_function("My first function!")

#### [1] "My first function!"


# Binary Operators
# The syntax for creating new binary operators in R is unlike anything else in
# R, but it allows you to define a new syntax for your function. I would only
# recommend making your own binary operator if you plan on using it often!

## User-defined binary operators have the following syntax:
##      %[whatever]% 
## where [whatever] represents any valid variable name.

### Let's say I wanted to define a binary operator that multiplied two numbers and
### then added one to the product. An implementation of that operator is below:

"%mult_add_one%" <- function(left, right){     #### Notice the quotation marks!
                        paste(left * right + 1)
}

### I could then use this binary operator like 
4 %mult_add_one% 5
#### [1] "21"

## Write your own binary operator below from absolute scratch! Your binary operator 
## must be called %p% so that the expression: "Good" %p% "job!" 
## will evaluate to: "Good job!"

"%p%" <- function(left, right){   #### Remember to add arguments!
        paste(left, right)
}

"Good" %p% "job!"

#### [1] "Good job!"


# Passing arguments in a function
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

# Unpacking 
# Let's explore how to "unpack" arguments from an ellipses when you use the
# ellipses as an argument in a function. Below I have an example function that
# is supposed to add two explicitly named arguments called alpha and beta.

### add_alpha_and_beta <- function(...){
### First we must capture the ellipsis inside of a list
###   and then assign the list to a variable. Let's name this
### variable `args`.

###   args <- list(...)

### We're now going to assume that there are two named arguments within args
###  with the names `alpha` and `beta.` We can extract named arguments from
###   the args list by using the name of the argument and double brackets. The
###   `args` variable is just a regular list after all!
 
###   alpha <- args[["alpha"]]
###   beta  <- args[["beta"]]

### Then we return the sum of alpha and beta.

###   alpha + beta 
### }

### Have you ever played Mad Libs before? The function below will construct a
### sentence from parts of speech that you provide as arguments. We'll write most
### of the function, but you'll need to unpack the appropriate arguments from the
### ellipses.

mad_libs <- function(...){
  args <- list(...)
  place <- args[["place"]]
  adjective <- args[["adjective"]]
  noun <- args[["noun"]]
  
  paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}

mad_libs(place = "NC", adjective = "angry", noun = "president")

#### [1] "News from NC today where angry students took to the streets in protest of the new president being installed on campus."



# Intro Functions cont
# You're free to implement the function my_mean however you want, as long as it
# returns the average of all of the numbers in `my_vector`.

### Hint #1: sum() returns the sum of a vector.
### 	Ex: sum(c(1, 2, 3)) evaluates to 6

### Hint #2: length() returns the size of a vector.
### 	Ex: length(c(1, 2, 3)) evaluates to 3

### Hint #3: The mean of all the numbers in a vector is equal to the sum of all of
###		   the numbers in the vector divided by the size of the vector.

### Note for those of you feeling super clever: Please do not use the mean()
### function while writing this function. We're trying to teach you something 
### here!


my_mean <- function(my_vector) {
        x<- sum(my_vector)/length(my_vector)
        x
}


my_mean(c(4,5,10))

#### [1] 6.33333

mean(c(4,5,10))

#### [1] 6.33333  - checking my_mean


