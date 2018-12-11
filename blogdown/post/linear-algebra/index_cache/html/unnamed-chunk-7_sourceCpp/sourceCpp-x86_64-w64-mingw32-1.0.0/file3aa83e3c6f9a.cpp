// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_scalar(const NumericMatrix& x, const int& scalar) {
  const arma::mat arma_matrix = as<arma::mat>(x);
  const arma::mat out = arma_matrix * scalar;
  
  return wrap(out);
}
