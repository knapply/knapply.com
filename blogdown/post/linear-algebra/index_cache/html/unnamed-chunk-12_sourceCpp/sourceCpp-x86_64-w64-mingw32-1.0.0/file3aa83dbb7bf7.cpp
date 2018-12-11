// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_vec(const NumericMatrix& mat, const NumericVector& col_vec) {
  const arma::mat arma_mat = as<arma::mat>(mat);
  const arma::colvec arma_col_vec = as<arma::colvec>(col_vec);
  
  const arma::mat out = arma_mat * arma_col_vec;
  
  return wrap(out);
}
