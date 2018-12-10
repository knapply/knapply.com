// ---- d1p1
#include <fstream>
#include <iostream>

int main() {
  std::fstream file_stream;
  file_stream.open("input-1.txt");
  if (!file_stream) {
    std::cout << "file not found" << std::endl; 
    exit(1);
  }
  
  int cum_sum = 0;
  int temp;
  while (file_stream >> temp) {
    cum_sum += temp;
  }
  file_stream.close();
  
  std::cout << cum_sum << std::endl;
  
  return 0;
}