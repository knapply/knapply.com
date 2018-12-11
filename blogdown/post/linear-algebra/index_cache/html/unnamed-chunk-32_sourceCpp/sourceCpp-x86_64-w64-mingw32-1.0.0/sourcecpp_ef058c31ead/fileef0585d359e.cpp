// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_transpose(const NumericMatrix& x) {
  const arma::mat arma_mat = as<arma::mat>(x);
  
  const arma::mat out = arma::trans(arma_mat);
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_arma_transpose
NumericMatrix cpp_arma_transpose(const NumericMatrix& x);
RcppExport SEXP sourceCpp_12_cpp_arma_transpose(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericMatrix& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_transpose(x));
    return rcpp_result_gen;
END_RCPP
}
