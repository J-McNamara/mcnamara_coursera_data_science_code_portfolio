## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  matrixCached <<- x
  inverseCached <<- solve(x)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  if (x == matrixCached) {
    return(inverseCached)
  }
  else {
    return(solve(x))
  }
}