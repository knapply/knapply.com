// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_vec_dot_mat(const NumericVector& row_vec, const NumericMatrix& mat) {
  const arma::mat arma_mat = as<arma::mat>(mat);
  const arma::rowvec arma_row_vec = as<arma::rowvec>(row_vec);
  
  const arma::mat out = arma_row_vec * arma_mat;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_arma_vec_dot_mat
NumericMatrix cpp_arma_vec_dot_mat(const NumericVector& row_vec, const NumericMatrix& mat);
RcppExport SEXP sourceCpp_7_cpp_arma_vec_dot_mat(SEXP row_vecSEXP, SEXP matSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type row_vec(row_vecSEXP);
    Rcpp::traits::input_parameter< const NumericMatrix& >::type mat(matSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_vec_dot_mat(row_vec, mat));
    return rcpp_result_gen;
END_RCPP
}
