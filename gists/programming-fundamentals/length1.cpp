#include <iostream>  // std::cout, std::endl
#include <vector>    // std::vector

using std::cout;
using std::endl;
using std::vector;

int length(vector<double> &x) {
	int out = 0;

    for (auto it = begin(x); it != end(x); ++it) {
        out++;
    }

	return out;
}

int main() {
    vector<double> v{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
    
    int result = length(v);
    
    cout << "length: " << result << endl;
    
    return 0;
}

//> length: 20