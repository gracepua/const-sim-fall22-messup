#include <iostream>
#include <fstream>
#include <vector>
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() {
   std::fstream readFile("simulation_data/psdOneFloat.bom", std::ios::binary);
   double var0, var1, var2;
   std::vector<double>  data, peak_mag; // i guess these need to be vectors
   std::vector<float> freq, peak_freq, derivative;

   // set the frequency array
   double ff = -25000000;
   for (int ii=0; ii<4096; ii++) {
      ff = ff + 12204;
      freq.push_back(ff);
      if (-1012204 < ff && ff < -987796) {
         std::cout << "ii = " << ii << std::endl;
      }
   }

   // read the psd.bin file and store the psd values
   readFile.open("simulation_data/psdOneFloat.bin"); // reading from bin file: successful!
   if(!readFile) {
      std::cout << "(r)Cannot open file!" << std::endl;
      return 1;
   }
   std::cout << "\nreading values from the .bin file...\n" << std::endl;


   // finding the derivative between adjacent points (i.e. 1 and 2)
   readFile.read((char*)&var0, 4);
   data.push_back(var0);

   double greatest = var0, greatest_index;
   int derv_index = 0, data_index = 1;

   while (true) { // note: don't use .eof() function. use this loop format
      readFile.read((char*)&var1, 4);
      if( readFile.eof() ) break;

      data.push_back(var1);

      if (var1 > greatest) {
         greatest = var1;
         greatest_index = data_index;
      }
      data_index++;
   }
   std::cout << "greatest = " << greatest << std::endl;
   std::cout << "greatest_index = " << greatest_index << std::endl;

   std::cout << "differences..." << std::endl;
   std::cout << "data[1966] - data[1967] = " << data[1966] << " - " << data[1967] << " = " << data[1966] - data[1967] << std::endl;
   std::cout << "data[1967] - data[1968] = " << data[1967] << " - " << data[1968] << " = " << data[1967] - data[1968] << std::endl;

   std::cout << "\nprogram finished" << std::endl;

   return 0;
} 