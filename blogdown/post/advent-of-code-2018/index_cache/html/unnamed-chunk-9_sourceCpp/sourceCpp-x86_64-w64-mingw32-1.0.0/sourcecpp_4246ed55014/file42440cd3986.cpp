// [[Rcpp::plugins(cpp14)]]
#include <Rcpp.h>

template <int RTYPE, typename T>
auto cpp_cumsum_last2_(const Rcpp::Vector<RTYPE>& x) {
  std::vector<T> cum_sum(x.size());
  std::partial_sum(std::begin(x), std::end(x), std::begin(cum_sum));

  return cum_sum.back();
}

// [[Rcpp::export]]
SEXP cpp_cumsum_last2(const SEXP& x) {
  switch( TYPEOF(x) ) {
    case INTSXP:
      return Rcpp::wrap( cpp_cumsum_last2_<INTSXP, int>(x) );
    case REALSXP:
      return Rcpp::wrap( cpp_cumsum_last2_<REALSXP, double>(x) );
  }
  Rcpp::warning("Invalid SEXPTYPE %d (%s).\n", TYPEOF(x), Rcpp::type2name(x));
  return R_NilValue;
}


#include <Rcpp.h>
// cpp_cumsum_last2
SEXP cpp_cumsum_last2(const SEXP& x);
RcppExport SEXP sourceCpp_1_cpp_cumsum_last2(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const SEXP& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_cumsum_last2(x));
    return rcpp_result_gen;
END_RCPP
}
