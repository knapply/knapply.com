// VS 2017, /EHsc
#include <algorithm> // std::for_each, std::unique, std::sort
#include <iostream>  // std::cout
#include <iterator>  // std::begin, std::end
#include <vector>    // std::vector

using std::cout;
using std::endl;
using std::find;
using std::for_each;
using std::sort;
using std::vector;

int main() {
    vector<int> v = { 3, 1, 2, 2, 3, 1 };

    sort(begin(v), end(v));                    // `unique()` requires that elements be sorted as it acts on adjacent duplicates
    v.erase(unique(begin(v), end(v)), end(v));

    cout << "unique: ";
    for_each(begin(v), end(v), [](const auto& out) { cout << out << " "; });

    return 0;
}

//> unique: 1 2 3
