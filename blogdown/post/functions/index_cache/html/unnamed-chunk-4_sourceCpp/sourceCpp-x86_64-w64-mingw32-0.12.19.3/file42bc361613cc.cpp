#include <Rcpp.h>

// [[Rcpp::export]]
int cpp_doubler(int x) {
  return x * 2;
}
