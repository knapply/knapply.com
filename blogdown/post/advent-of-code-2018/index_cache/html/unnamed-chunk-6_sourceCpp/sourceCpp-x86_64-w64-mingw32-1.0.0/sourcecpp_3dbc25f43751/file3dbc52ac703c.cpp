// [[Rcpp::plugins(cpp14)]]
#include <Rcpp.h>
#include <fstream>

// [[Rcpp::export]]
auto rcpp_day1_part1(Rcpp::String path = "input1-1.txt") {
  std::fstream file_stream;
  file_stream.open(path);
  if (!file_stream) {
    std::cout << "file not found";
    exit(1);
  }

  int cum_sum = 0;
  int temp;
  while (file_stream >> temp) {
    cum_sum += temp;
  }
  file_stream.close();

  return cum_sum;
}


#include <Rcpp.h>
// rcpp_day1_part1
auto rcpp_day1_part1(Rcpp::String path);
RcppExport SEXP sourceCpp_5_rcpp_day1_part1(SEXP pathSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::String >::type path(pathSEXP);
    rcpp_result_gen = Rcpp::wrap(rcpp_day1_part1(path));
    return rcpp_result_gen;
END_RCPP
}
