# install.packages("codetools")
library(codetools)
library(Metrics)

# Step 1
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
create_data_partition <- function(n, p) {
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

body(create_data_partition) # no comments are presented

create_data_partition # how the function was defined

codetools::findGlobals(create_data_partition)

formals(create_data_partition)

# test
partition <- create_data_partition(100, 0.75)
setdiff(unlist(partition), 1:100)

# Step 2: Default arguemnts
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
create_data_partition <- function(n, p = 0.75) {
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

# Step 3: Validation of arguments
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

create_data_partition(100, 2) # the message is not super intuitive
create_data_partition(-1, 0.75) # even more dengerous,
                                # since does not throw an error


create_data_partition <- function(n, p = 0.75) {
    
    if (n < 2)
        stop("Please specify the valid value of n.")
    
    if (p < 0 || p > 1)
        stop("Please specify the valid value of p.")
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

create_data_partition(100, 2)
create_data_partition(-1, 0.75)

#-------------------------------------------------------------------------------

create_data_partition(100, NA)
create_data_partition(NaN, 0.75)

create_data_partition <- function(n, p = 0.75) {
    
    if (n < 2 || any(is.na(n)))
        stop("Please specify the valid value of n.")
    
    if (p < 0 || p > 1 || any(is.na(n)))
        stop("Please specify the valid value of p.")
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

create_data_partition(100, NA) # again error with the same message as before,
                               # order metters!
                               # short circuiting
create_data_partition(NaN, 0.75)

create_data_partition <- function(n, p = 0.75) {
    
    if (any(is.na(n)) || n < 2)
        stop("Please specify the valid value of n.")
    
    if (any(is.na(p)) || p < 0 || p > 1)
        stop("Please specify the valid value of p.")
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

create_data_partition(100, NA)
create_data_partition(NaN, 0.75)

#-------------------------------------------------------------------------------

# Exercise

create_data_partition(100, numeric())
create_data_partition(c(100, 100), 0.75) # even more dengerous 

create_data_partition(100, list())
create_data_partition("100", 0.75)

create_data_partition(NULL, 0.75)
create_data_partition(100, NULL)

create_data_partition <- function(n, p = 0.75) {
    
    if (!is.numeric(n) || length(n) != 1 || is.na(n) || n < 2)
        stop("Please specify the valid value of n.")
    
    if (!is.numeric(p) || length(p) != 1 || is.na(p) || p < 0 || p > 1)
        stop("Please specify the valid value of p.")
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

create_data_partition(100, numeric())
create_data_partition(c(100, 100), 0.75)

create_data_partition(100, list())
create_data_partition("100", 0.75)

create_data_partition(NULL, 0.75)
create_data_partition(100, NULL)


#-------------------------------------------------------------------------------
create_data_partition <- function(n, p = 0.75) {
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p >= 0 && 
                  p <= 1)
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}


create_data_partition <- function(n, p = 0.75) {
    
    # validate n
    stopifnot(is.numeric(n), length(n) >= 1, all(!is.na(n)), all(n >= 2))
    
    if (length(n) > 1) {
        n <- n[1]
        warning("Only the first element of n will be used.")
    }
    
    if (!is.integer(n)){
        n <- as.integer(n)
        warning("n is coerced to an integer.")
    }
    
    # validate p
    stopifnot(is.numeric(p), length(p) >= 1, all(!is.na(p)), all(p > 0),
              all(p < 1))
    
    if (length(p) > 1) {
        p <- p[1]
        warning("Only the first element of p will be used.")
    }
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = ceiling(n * p))
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

# Step 4: Cathing an error
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Here we use a simplified version of validation

create_data_partition <- function(n, p = 0.75) {
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p >= 0 && 
                  p <= 1)
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}


x <- runif(n = 99)
sdata <- data.frame(x = x, y = 3 * x + rnorm(99))

get_rmse <- function() {
    
    partition <- create_data_partition(99, 0.01)
    fit <- lm(y ~ x, sdata[partition$train, ])
    
    Metrics::rmse(
        sdata[partition$test, "y"],
        predict(fit, newdata = sdata[partition$test, ])
    )
    
}

get_rmse()

traceback()

get_rmse <- function() {
    
    browser()
       
    partition <- create_data_partition(99, 0.01)
    fit <- lm(y ~ x, sdata[partition$train, ])
    
    Metrics::rmse(
        sdata[partition$test, "y"],
        predict(fit, newdata = sdata[partition$test, ])
    )
    
}

get_rmse() # and inspect partition


create_data_partition <- function(n, p = 0.75) {
    
    browser()
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p >= 0 && 
                  p <= 1)
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = n * p)
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

create_data_partition(99, 0.01)


99 * 0.01

as.integer(99 * 0.01)

ceiling(99 * 0.01)

100 * 0.9999

as.integer(100 * 0.9999)

ceiling(100 * 0.9999)

create_data_partition <- function(n, p = 0.75) {
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p > 0 && 
                  p < 1)
    
    # randomly draw n * p numbers from 1:n
    train <- sample(x = 1:n, size = ceiling(n * p))
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

get_rmse <- function() {
    
    partition <- create_data_partition(99, 0.01)
    fit <- lm(y ~ x, sdata[partition$train, ])
    
    Metrics::rmse(
        sdata[partition$test, "y"],
        predict(fit, newdata = sdata[partition$test, ])
    )
    
}

get_rmse()

# Step 4: Adding feature: balancing data
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# This section was not covered in the class.

create_data_partition <- function(y, n, p = 0.75) {
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p > 0 && 
                  p < 1)
    
    success <- which(y == 1)
    fails <- which(y == 0)
    
    train <- sample(
        sample(success, size = ceiling(length(success) * p)),
        sample(fails, size = ceiling(length(fails) * p))
    )
    
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

y <- c(rep(1, 2500), rep(0, 7500))

partition <- create_data_partition(n = 200000, p = 0.75, y = y)

create_data_partition <- function(y, n, p = 0.75) {
    
    browser()
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p > 0 && 
                  p < 1)
    
    success <- which(y == 1)
    fails <- which(y == 0)
    
    train <- sample(
        sample(success, size = ceiling(length(success) * p)),
        sample(fails, size = ceiling(length(fails) * p))
    )
    
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}


create_data_partition <- function(y, n, p = 0.75) {
    
    stopifnot(is.numeric(n) && length(n) == 1 && !is.na(n) && n >= 2)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p > 0 && 
                  p < 1)
    
    success <- which(y == 1)
    fails <- which(y == 0)
    
    train <- sample(
        c(
            sample(success, size = ceiling(length(success) * p)),
            sample(fails, size = ceiling(length(fails) * p))
        )
    )
    
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}


partition <- create_data_partition(n = 200000, p = 0.75, y = y)

prop.table(table(y))


prop.table(table(y[partition$train]))
prop.table(table(y[partition$test]))

# redundant argument

create_data_partition <- function(y, p = 0.75) {
    
    n <- length(y)
    
    stopifnot(is.numeric(p) && length(p) == 1 && !is.na(p) && p > 0 && 
                  p < 1)
    
    success <- which(y == 1)
    fails <- which(y == 0)
    
    train <- sample(
        sample(success, size = ceiling(length(success) * p)),
        sample(fails, size = ceiling(length(fails) * p))
    )
    
    test <- setdiff(1:n, train)
    
    list(train = train, test = test)
}

# ... 
# - check which levels y has and how many instances in each of them
# - type of y
# ...

# testthat 

# GitHub issues:
# - validate arguemnts
# - test ... 


