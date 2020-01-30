library(Thiele)

x <- (-100 : 100) / 33
y <- dnorm(x)
xin <- 1.2
N <- length(x)
N2 <- N * (N - 1) / 2
r <- rep(0, N2)
n <- 0
ret_val <- 0

###################
#### Exemple 1 ####
###################
.C("call_thiele", x = as.double(x), y = as.double(y), r = as.double(r), xin = as.double(xin),
      n = as.integer(n), N = as.integer(N), ret_val = as.double(ret_val))

###################
#### Exemple 2 ####
###################
fn <- function(values)
{
  val <- rep(0, length(values))
  for(i in 1 : length(values))
  {
    val_temp <- values[i]
    val[i] <- .C("call_thiele", x = as.double(x), y = as.double(y), r = as.double(r), xin = as.double(val_temp),
                 n = as.integer(n), N = as.integer(N), ret_val = as.double(ret_val))$ret_val
  }

  return(val)
}

plot(x, y, xlim = c(-3, 3), ylim = c(0, 0.4))
curve(fn(x), xlim = c(-100/33, 100 / 33), ylim = c(0, 2), col = "red", add = TRUE)
