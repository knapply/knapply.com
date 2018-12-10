// ---- day1_part1
#include "read_int.cpp"
#include <numeric>

int main() {
  auto dat = read_int("input1-2.txt");
  
  auto res = std::accumulate(std::begin(dat), std::end(dat), 0);
  
  std::cout << res << std::endl;
  
  return 0;
}