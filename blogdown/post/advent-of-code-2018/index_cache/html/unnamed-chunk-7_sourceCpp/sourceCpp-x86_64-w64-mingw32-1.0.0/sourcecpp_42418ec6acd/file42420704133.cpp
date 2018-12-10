// [[Rcpp::plugins(cpp14)]]
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_cumsum_last1(const NumericVector& x) {
  NumericVector cum_sum = cumsum(x);
  
  double out = cum_sum[x.size() - 1];
  
  return out;
}


#include <Rcpp.h>
// cpp_cumsum_last1
auto cpp_cumsum_last1(const NumericVector& x);
RcppExport SEXP sourceCpp_3_cpp_cumsum_last1(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_cumsum_last1(x));
    return rcpp_result_gen;
END_RCPP
}
