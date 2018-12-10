// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_mat(NumericMatrix mat1, NumericMatrix mat2) {
  auto arma_mat1 = as<arma::mat>(mat1);
  auto arma_mat2 = as<arma::mat>(mat2);
  
  auto out = arma_mat1 * arma_mat2;
  
  return wrap(out);
}
