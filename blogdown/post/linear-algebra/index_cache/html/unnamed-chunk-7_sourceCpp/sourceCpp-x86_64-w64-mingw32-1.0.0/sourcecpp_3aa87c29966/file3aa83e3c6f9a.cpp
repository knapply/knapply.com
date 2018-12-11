// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_scalar(const NumericMatrix& x, const int& scalar) {
  const arma::mat arma_matrix = as<arma::mat>(x);
  const arma::mat out = arma_matrix * scalar;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_arma_mat_dot_scalar
NumericMatrix cpp_arma_mat_dot_scalar(const NumericMatrix& x, const int& scalar);
RcppExport SEXP sourceCpp_5_cpp_arma_mat_dot_scalar(SEXP xSEXP, SEXP scalarSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericMatrix& >::type x(xSEXP);
    Rcpp::traits::input_parameter< const int& >::type scalar(scalarSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_mat_dot_scalar(x, scalar));
    return rcpp_result_gen;
END_RCPP
}
