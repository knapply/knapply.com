// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_determinant(NumericMatrix x) {
  auto arma_mat = as<arma::mat>(x);
  
  auto out = arma::det(arma_mat);

  return out;
}


#include <Rcpp.h>
// cpp_determinant
auto cpp_determinant(NumericMatrix x);
RcppExport SEXP sourceCpp_1_cpp_determinant(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_determinant(x));
    return rcpp_result_gen;
END_RCPP
}
