// [[Rcpp::plugins(cpp14)]]
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
auto cpp_cumsum_last1(const NumericVector& x) {
  NumericVector cum_sum = cumsum(x);
  
  double out = cum_sum[x.size() - 1];
  
  return out;
}
