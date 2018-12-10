// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_mat(NumericMatrix mat1, NumericMatrix mat2) {
  auto arma_mat1 = as<arma::mat>(mat1);
  auto arma_mat2 = as<arma::mat>(mat2);
  
  auto out = arma_mat1 * arma_mat2;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_mat_dot_mat
auto cpp_mat_dot_mat(NumericMatrix mat1, NumericMatrix mat2);
RcppExport SEXP sourceCpp_1_cpp_mat_dot_mat(SEXP mat1SEXP, SEXP mat2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type mat1(mat1SEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type mat2(mat2SEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_mat_dot_mat(mat1, mat2));
    return rcpp_result_gen;
END_RCPP
}
