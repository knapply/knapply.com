// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_mat(const NumericMatrix& mat1, const NumericMatrix& mat2) {
  const arma::mat arma_mat1 = as<arma::mat>(mat1);
  const arma::mat arma_mat2 = as<arma::mat>(mat2);
  
  const arma::mat out = arma_mat1 * arma_mat2;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_arma_mat_dot_mat
NumericMatrix cpp_arma_mat_dot_mat(const NumericMatrix& mat1, const NumericMatrix& mat2);
RcppExport SEXP sourceCpp_7_cpp_arma_mat_dot_mat(SEXP mat1SEXP, SEXP mat2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericMatrix& >::type mat1(mat1SEXP);
    Rcpp::traits::input_parameter< const NumericMatrix& >::type mat2(mat2SEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_mat_dot_mat(mat1, mat2));
    return rcpp_result_gen;
END_RCPP
}
