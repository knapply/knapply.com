// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
double cpp_arma_determinant(const NumericMatrix& x) {
  const arma::mat arma_mat = as<arma::mat>(x);
  
  const double out = arma::det(arma_mat);

  return out;
}
