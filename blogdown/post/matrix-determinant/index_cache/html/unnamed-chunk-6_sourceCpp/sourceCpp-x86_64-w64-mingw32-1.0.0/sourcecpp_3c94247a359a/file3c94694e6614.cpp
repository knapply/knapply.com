// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
double cpp_arma_determinant(const NumericMatrix& x) {
  const arma::mat arma_mat = as<arma::mat>(x);
  
  const double out = arma::det(arma_mat);

  return out;
}


#include <Rcpp.h>
// cpp_arma_determinant
double cpp_arma_determinant(const NumericMatrix& x);
RcppExport SEXP sourceCpp_3_cpp_arma_determinant(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericMatrix& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_determinant(x));
    return rcpp_result_gen;
END_RCPP
}
