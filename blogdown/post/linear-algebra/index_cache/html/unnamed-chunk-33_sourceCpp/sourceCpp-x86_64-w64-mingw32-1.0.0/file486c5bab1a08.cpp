// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_determinant(NumericMatrix x) {
  auto arma_mat = as<arma::mat>(x);
  
  auto out = arma::det(arma_mat);

  return out;
}
