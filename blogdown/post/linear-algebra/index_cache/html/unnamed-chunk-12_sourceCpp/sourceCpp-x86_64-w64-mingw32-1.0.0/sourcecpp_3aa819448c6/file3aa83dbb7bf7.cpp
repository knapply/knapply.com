// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix cpp_arma_mat_dot_vec(const NumericMatrix& mat, const NumericVector& col_vec) {
  const arma::mat arma_mat = as<arma::mat>(mat);
  const arma::colvec arma_col_vec = as<arma::colvec>(col_vec);
  
  const arma::mat out = arma_mat * arma_col_vec;
  
  return wrap(out);
}


#include <Rcpp.h>
// cpp_arma_mat_dot_vec
NumericMatrix cpp_arma_mat_dot_vec(const NumericMatrix& mat, const NumericVector& col_vec);
RcppExport SEXP sourceCpp_5_cpp_arma_mat_dot_vec(SEXP matSEXP, SEXP col_vecSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericMatrix& >::type mat(matSEXP);
    Rcpp::traits::input_parameter< const NumericVector& >::type col_vec(col_vecSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_arma_mat_dot_vec(mat, col_vec));
    return rcpp_result_gen;
END_RCPP
}
