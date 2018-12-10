// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_scalar(NumericMatrix x, int scalar) {
  auto arma_matrix = as<arma::mat>(x);
  auto out = arma_matrix * scalar;
  
  return wrap(out);
}
