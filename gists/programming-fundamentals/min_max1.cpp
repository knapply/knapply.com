#include <iostream> // std::cout, std::endl
#include <iterator> // std::next
#include <vector>   // std::vector

using std::cout;
using std::endl;
using std::next;
using std::vector;

double cpp_min(vector<double> &x) {                        // `&`: pass `x` by reference
    double out = x.at(0);                                  // out starts `at()` `x`'s first element (v[0] = 1)

    for (auto it = next(begin(x)); it != end(x); ++it) {   // `begin()` returns iterator starting at `x[0]`, `next()` advances 1 position to `x[1]`
        if (*it < out) {                                   // `*` dereferences `it` to access the value to which it points
            out = *it;                                     // if the dereferenced value is less than `out`, out is updated
        }
    }

    return out;
}

double cpp_max(vector<double> &x) {
    double out = x.at(0);

    for (auto it = next(begin(x)); it != end(x); ++it) {
        if (*it > out) {
            out = *it;
        }
    }

    return out;
}

int main() {
    vector<double> v{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };

    double min_result = cpp_min(v);
    double max_result = cpp_max(v);

    cout << "min: " << min_result << endl;
    cout << "max: " << max_result << endl;

    return 0;
}

//> min: 1
//> max: 20