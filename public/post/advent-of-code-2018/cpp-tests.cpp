// [[Rcpp::plugins(cpp14)]]
#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
int rcpp_day1_part2(const CharacterVector& x) {
  std::unordered_map<String, std::size_t> counts;
  
  int twos = 0;
  int threes = 0;
  
  for (auto i : x) {
    Rcout << i << std::endl;
    for (auto j : i) {
      counts[j]++;
    }
    for (auto k : counts) {
      if (k.second == 2) {
        twos++;
        break;
      }
    }
    for (auto k : counts) {
      if (k.second == 3) {
        threes++;
        break;
      }
    }
    counts.clear();
  }
  
  return twos * threes;
}

/*** R
# dat <- c("abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab")
rcpp_day1_part2(dat)
*/

