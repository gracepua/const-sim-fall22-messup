#include <iostream>

int main() {

    for (int ii=0; ii<20; ii++){
        if (true) {
            if (ii % 7 != 0) std::cout << "ii = " << ii << std::endl;
            else continue;
        }
    }
    return 0;
}