// VS 2017, /EHsc
#include <algorithm> // std::min_element, std::max_element
#include <iostream>  // std::cout, std::endl
#include <vector>    // std::vector

using std::cout;
using std::endl;
using std::max_element;
using std::min_element;
using std::vector;

int main() {
    vector<double> v{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };

    vector<double>::iterator min_result = min_element(begin(v), end(v));
    vector<double>::iterator max_result = max_element(begin(v), end(v));

    cout << "min: " << *min_result << endl;
    cout << "max: " << *max_result << endl;

    return 0;
}

//> min: 1
//> max: 20