// [[Rcpp::plugins(cpp14)]]
// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_mat_dot_vec(NumericMatrix mat, NumericVector col_vec) {
  auto arma_mat = as<arma::mat>(mat);
  auto arma_vec = as<arma::colvec>(col_vec);
  
  auto out = arma_mat * arma_vec;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_mat_dot_vec
auto cpp_mat_dot_vec(NumericMatrix mat, NumericVector col_vec);
RcppExport SEXP sourceCpp_1_cpp_mat_dot_vec(SEXP matSEXP, SEXP col_vecSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type mat(matSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type col_vec(col_vecSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_mat_dot_vec(mat, col_vec));
    return rcpp_result_gen;
END_RCPP
}
