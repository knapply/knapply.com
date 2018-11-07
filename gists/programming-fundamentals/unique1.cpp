// VS 2017, /EHsc  
#include <algorithm> // std::for_each
#include <iostream>  // std::cout
#include <vector>    // std::vector

using std::cout;
using std::endl;
using std::find;
using std::for_each;
using std::vector;

vector<double> cpp_unique_set(vector<double> &x) {
    vector<double> out;

    for (auto i : x) {
		auto res = find(begin(out), end(out), i);
		if (res == end(out)) {
			out.push_back(i);
		}
	}

	return out;
}

int main() {
	vector<double> v{ 3, 1, 2, 2, 3, 1 };

	vector<double> out = cpp_unique_set(v);

    cout << "unique: ";
    for_each(begin(out), end(out), [](const auto& i) { cout << i << " "; });

	return 0;
}

//> unique: 3 1 2