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