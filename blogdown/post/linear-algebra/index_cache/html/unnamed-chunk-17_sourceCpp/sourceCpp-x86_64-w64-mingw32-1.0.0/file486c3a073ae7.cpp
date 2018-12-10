// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_vec_dot_mat(NumericVector row_vec, NumericMatrix mat) {
  auto arma_mat = as<arma::mat>(mat);
  auto arma_vec = as<arma::rowvec>(row_vec);
  
  auto out = arma_vec * arma_mat;
  
  return wrap(out);
}
