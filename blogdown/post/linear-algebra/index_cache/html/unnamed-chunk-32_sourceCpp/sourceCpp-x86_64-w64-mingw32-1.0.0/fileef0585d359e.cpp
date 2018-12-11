// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_transpose(const NumericMatrix& x) {
  const arma::mat arma_mat = as<arma::mat>(x);
  
  const arma::mat out = arma::trans(arma_mat);
  
  return wrap(out);
}
