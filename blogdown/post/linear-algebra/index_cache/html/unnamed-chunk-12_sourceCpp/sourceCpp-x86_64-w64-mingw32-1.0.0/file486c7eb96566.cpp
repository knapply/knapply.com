// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_vec(NumericMatrix mat, NumericVector col_vec) {
  auto arma_mat = as<arma::mat>(mat);
  auto arma_vec = as<arma::colvec>(col_vec);
  
  auto out = arma_mat * arma_vec;
  
  return wrap(out);
}
