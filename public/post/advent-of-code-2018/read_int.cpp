// ---- read_int
#include <fstream>
#include <iostream>
#include <vector>

std::vector<int> read_int(std::string path) {
  std::fstream file_stream;
  file_stream.open(path);
  if (!file_stream) {
    std::cout << "file not found" << std::endl; 
    exit(1);
  }
  
  std::vector<int> out;
  int temp;
  while (file_stream >> temp) {
    out.push_back(temp);
  }
  file_stream.close();
  
  return out;
}