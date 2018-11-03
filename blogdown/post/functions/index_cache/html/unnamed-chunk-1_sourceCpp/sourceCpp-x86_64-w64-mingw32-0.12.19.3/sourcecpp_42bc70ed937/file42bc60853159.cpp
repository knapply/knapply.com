#include <Rcpp.h>

// [[Rcpp::export]]
int cpp_doubler(int x) {
  return x * 2;
}


#include <Rcpp.h>
// cpp_doubler
int cpp_doubler(int x);
RcppExport SEXP sourceCpp_1_cpp_doubler(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_doubler(x));
    return rcpp_result_gen;
END_RCPP
}
