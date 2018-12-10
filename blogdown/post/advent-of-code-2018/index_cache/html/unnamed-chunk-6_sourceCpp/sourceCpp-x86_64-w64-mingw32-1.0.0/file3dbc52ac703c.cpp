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
