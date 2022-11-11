#include <iostream>
#include <ctime>

using namespace std;

struct TestStruct { // note typedef is not needed */
    int values[10]; // specified the size
  };

// function to generate and retrun random numbers.
int * getRandom( ) {
  static int  r[10];
  srand( (unsigned)time( NULL ) );   // set the seed
  for (int i = 0; i < 10; ++i) {
    r[i] = rand();
    cout << r[i] << endl;
  }

  return r;
}

// main function to call above defined function.
int main () {

  // a pointer to an int.
  int *p;

  p = getRandom();

  for ( int i = 0; i < 10; i++ ) {
    cout << "*(p + " << i << ") : ";
    cout << *(p + i) << endl;
  }

  // auto [value1, value2, value3] = foo(); // structured binding declaration
  // cout << value1 << ", " << value2 << ", " << value3 << endl;

   return 0;
} 

// C++ program to return a structure from
// a function using Call By Value Method

// #include <iostream>
// #include <stdlib.h>

// using namespace std;

// // required structure
// struct TestStruct { // note typedef is not needed */
//   // int values[10] = {1,2,3,4,5,6,7,8,9,0}; // specified the size
//   int values0[10];
//   int values1[10];
// };

// // return type of the function is structure
// TestStruct data(TestStruct E) {
// 	// E.values = {1,2,3,4,5,6,7,8,9,0};  // Assigning the values to elements
//   for (int i=0; i<10; i++) {
//     E.values0[i] = i;
//     E.values1[i] = i+2;
//   }
//   return (E);   // returning structure
// }

// // Driver code
// int main() {

// 	// creating object of Employee
// 	TestStruct Emp;

// 	// calling function data to assign value
// 	Emp = data(Emp);

// 	// display the output
//   for (int j=0; j<10; j++) {
// 	  cout << "values0[" << j << "] = " << Emp.values0[j] << "\t";
//     cout << "values1[" << j << "] = " << Emp.values1[j] << "\t" << endl;
//   }
// 	return 0;
// }


