// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_scalar(NumericMatrix x, int scalar) {
  auto arma_matrix = as<arma::mat>(x);
  auto out = arma_matrix * scalar;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_mat_dot_scalar
auto cpp_mat_dot_scalar(NumericMatrix x, int scalar);
RcppExport SEXP sourceCpp_1_cpp_mat_dot_scalar(SEXP xSEXP, SEXP scalarSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type scalar(scalarSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_mat_dot_scalar(x, scalar));
    return rcpp_result_gen;
END_RCPP
}
