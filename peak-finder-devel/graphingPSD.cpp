/* 
 * 
 * Author: Grace Palenapastd
 * Revision Date: 10.26.2022
 * 
 * read PSD.bin data file and find the peaks 
 *
 * Notes: 
 * - next approach to this code
 *    - find the mean of the whole data set
 *    - 5 dB threshold above the mean
 *    - record the frequency and the gain
 * - another approach to 
 *    - "take the derivative"?
 *    - could be a more dynamic way of finding these peaks
 */

#include <iostream>
#include <fstream>
#include <vector>
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() {
   std::fstream readFile("psdFour.bin", std::ios::binary);
   double var, spike, sum = 0, threshold;
   std::vector<double> freq, data, peak_freqs, peak_mag; // i guess these need to be vectors

   // set the frequency array
   double ff = -25000000;
   for (int ii=0; ii<4096; ii++) {
      ff = ff + 12204;
      freq.push_back(ff);
      // std::cout << freq[kk] << "    \t";
      // if (kk % 10 == 0) std::cout << std::endl;
   }
   // std::cout << std::endl;
   
   readFile.open("psdFour.bin"); // reading from bin file: successful!
   if(!readFile) {
      std::cout << "(r)Cannot open file!" << std::endl;
      return 1;
   }


   // read the psd.bin file and store the psd values
   std::cout << "\nreading values from the .bin file..." << std::endl;
   
   double count = 0, n = 0;
   while (true) { // note: don't use .eof() function. use this loop format
      readFile.read((char*)&var, 8);
      if( readFile.eof() ) break;

      data.push_back(var);
      sum += var;

      std::cout << var << "     \t";
      count++;
      n++;
      if (n == 10) {
         std::cout << "\n";
         n = 0;
      }
   }
   readFile.close();
   
   std::cout << "\nprogram finished" << std::endl;

   plt::plot(freq, data);
   plt::xlabel("frequency");
   plt::ylabel("magnitude");
   plt::show();

   return 0;
} 