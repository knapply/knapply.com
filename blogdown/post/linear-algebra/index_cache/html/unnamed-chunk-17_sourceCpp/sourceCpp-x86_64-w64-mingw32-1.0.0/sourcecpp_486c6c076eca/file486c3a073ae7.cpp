// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_vec_dot_mat(NumericVector row_vec, NumericMatrix mat) {
  auto arma_mat = as<arma::mat>(mat);
  auto arma_vec = as<arma::rowvec>(row_vec);
  
  auto out = arma_vec * arma_mat;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_vec_dot_mat
auto cpp_vec_dot_mat(NumericVector row_vec, NumericMatrix mat);
RcppExport SEXP sourceCpp_1_cpp_vec_dot_mat(SEXP row_vecSEXP, SEXP matSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type row_vec(row_vecSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type mat(matSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_vec_dot_mat(row_vec, mat));
    return rcpp_result_gen;
END_RCPP
}
