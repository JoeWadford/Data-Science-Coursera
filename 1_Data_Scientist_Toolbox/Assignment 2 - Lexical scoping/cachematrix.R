## Coursera: R Programming - Week 3
## Assignment 2: Lexical Scoping

## makeCacheMatrix = this function creates a special matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) i <<- inverse
        getinverse <- function() i 
        list(set = set, 
             get = get,
             setinverse = setinverse,
             getinverse = getinverse)

}


## cacheSolve = this function computes the inverse of the special matrix return by makeCacheMatrix above.  
        ## if the inverse has already been calculated (and the matrix has not changed) 
        ## then the cacheSolve should retrieve the inverse from the cache

cacheSolve <- function(x, ...) {
        i <- x$getinverse()
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinverse(i)
        i
}


