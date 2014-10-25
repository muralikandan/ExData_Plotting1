##function to create martix a special "matrix" object and cache its inverse to
##current environment
makeCacheMatrix <- function(x = matrix()) {
        matx_inv <- NULL
        #Method to cache matrix to current environment
        setMatrix <- function(y) {
                #caching matrix
                x <<- y
                matx_inv <<- NULL
        }
        #Method to return matrix from cache
        getMatrix <- function() {
                #return matrix from cache
                x
        }
        #Method to cache matrix inverse to current environment
        setInverse <- function(inverse) {
                #cache matrix inverse
                matx_inv <<- inverse
        }
        #Method to return cached version of matrix inverse
        getInverse <- function() {
                #return matrix inverse from cache
                matx_inv
        }
        ## Returns list of matrix related function
        list(setMatrix = setMatrix, getMatrix = getMatrix,
             setInverse = setInverse,
             getInverse = getInverse)

}

## Method to compute the inverse of the special matrix returned by "makeCacheMatrix"
## above. If the inverse has already been calculated (and the matrix has not
## changed), then the "cachesolve" should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Get the inverse of matrix 'x' from cache
        inv_matrix<- x$getInverse()
        ## Check whether cached matrix is not null
        if( !is.null(inv_matrix) ) {
                message("getting cached data")
                ## Just return the inverse if its already set
                return(inv_matrix)
        }
        ##Since matrix not in cache computing matrix inverse
        ## Get the matrix from our object
        matrix_cache <- x$getMatrix()
        ## Calculate the inverse using matrix multiplication
        inv_matrix <- solve(matrix_cache,...)
        ## Set the inverse to the object
        x$setInverse(inv_matrix)
        ## Return the inverse of matrix 'x'
        inv_matrix
}
