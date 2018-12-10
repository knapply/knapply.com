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
