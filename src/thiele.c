/* This code is inspired from the code avaiable at https://rosettacode.org/wiki/Thiele%27s_interpolation_formula */

#include <R.h>
#include <time.h>
#include <Rmath.h>
#include <Rinternals.h> // RK addition
#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

double rho(double *x, double *y, double *r, int i, int n, int N)
{
  if(n < 0) return 0;
  if(!n) return y[i];
  int idx = (N - 1 - n) * (N - n) / 2 + i;

  if(r[idx] != r[idx])
  {
    r[idx] = (x[i] - x[i + n]) / (rho(x, y, r, i, n - 1, N) - rho(x, y, r, i + 1, n - 1, N)) + rho(x, y, r, i + 1, n - 2, N);
  }

  return r[idx];
}

double thiele(double *x, double *y, double *r, double *xin, int n, int N)
{
  if(n > N - 1) return 1;
  return rho(x, y, r, 0, n, N) - rho(x, y, r, 0, n - 2, N) + (xin[0] - x[n]) / thiele(x, y, r, xin, n + 1, N);
}

void call_thiele(double *x, double *y, double *r, double *xin, int *n_in, int *N_in, double *ret_val)
{
  int n = n_in[0];
  int N = N_in[0];
  int N2 = N * (N - 1) / 2;
  int i;

  for(i = 0; i < N2; i++)
  {
    r[i] = 0/0.;
  }

  *ret_val = thiele(x, y, r, xin, n, N);
}

