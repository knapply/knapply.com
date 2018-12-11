// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_mat(const NumericMatrix& mat1, const NumericMatrix& mat2) {
  const arma::mat arma_mat1 = as<arma::mat>(mat1);
  const arma::mat arma_mat2 = as<arma::mat>(mat2);
  
  const arma::mat out = arma_mat1 * arma_mat2;
  
  return wrap(out);
}
