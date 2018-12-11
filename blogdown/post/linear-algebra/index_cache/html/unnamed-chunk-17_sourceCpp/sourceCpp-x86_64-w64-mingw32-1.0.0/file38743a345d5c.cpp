// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_vec_dot_mat(const NumericVector& row_vec, const NumericMatrix& mat) {
  const arma::mat arma_mat = as<arma::mat>(mat);
  const arma::rowvec arma_row_vec = as<arma::rowvec>(row_vec);
  
  const arma::mat out = arma_row_vec * arma_mat;
  
  return wrap(out);
}
