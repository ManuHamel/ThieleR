#' @param x is a vector of the x values
#' @param y is a vector of f(x)
#' @param xin is the value at which the Thiele interpolation is evaluated.
#' @export
thiele <- function(x, y, xin)
{
  N <- length(x)
  N2 <- N * (N - 1) / 2
  r <- rep(0, N2)
  n <- 0
  nb_xin <- length(xin)
  ret_val <- rep(0, nb_xin)
  ret_val_temp <- 0
  for(i in 1 : nb_xin)
  {
    val_temp <- xin[i]
    ret_val[i] <- .C("call_thiele", x = as.double(x), y = as.double(y), r = as.double(r), xin = as.double(val_temp),
                     n = as.integer(n), N = as.integer(N), ret_val = as.double(ret_val_temp))$ret_val
  }

  return(ret_val)
}
