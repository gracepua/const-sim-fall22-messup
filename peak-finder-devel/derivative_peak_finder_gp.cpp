/* 
 * 
 * Author: Grace Palenapastd
 * Revision Date: 10.27.2022
 * 
 * read PSD.bin data file and find the peaks 
 *
 * Notes: 
 * - how it works:
 *    - "take the derivative"?
 *    - could be a more dynamic way of finding these peaks
 *    - find the difference between neighboring points basically
 * 1. find the first two points
 * 2. find the gain difference
 * 3. if greater than a certain value, then record the point?

 * - possibly take the difference/derivative between every two data points (do this later)
 *    - i.e. points 1 and 3, then 2 and 4 
 */

#include <iostream>
#include <fstream>
#include <vector>
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() {
   std::fstream readFile("simulation_data/psdOneFloat.bin", std::ios::binary);
   float var0, var1, var2, temp_dif;
   std::vector<double> freq, peak_freq, peak_mag; // i guess these need to be vectors
   std::vector<float> data, derivative;

   // set the frequency array
   double ff = -25000000;
   for (int ii=0; ii<4096; ii++) {
      ff = ff + 12204;
      freq.push_back(ff);
      // if (-1012204 < ff && ff < -987796) {
      //    std::cout << "ii = " << ii << std::endl;
      // }
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

   float greatest = var0;
   int derv_index = 0, data_index = 1, greatest_index = 0;

   while (true) { // note: don't use .eof() function. use this loop format
      readFile.read((char*)&var1, 4);
      if( readFile.eof() ) break;

      data.push_back(var1);

      temp_dif = var0-var1;
      derivative.push_back(temp_dif);
      var0 = var1;
      derv_index++;
      data_index++;
   }
   // std::cout << "data[1965] = " << data[1965] << "\tdata[1967] = " << data[1967] << "\n" << std::endl;
   // std::cout << "greatest = " << greatest << std::endl;
   // std::cout << "greatest_index = " << greatest_index << std::endl;


   std::cout << "find the largest magnitude change in the derivative vector...\n" << std::endl;
   int n=0;
   float spike = abs(derivative[0]), bigindex;
   for (int kk=1; kk<derivative.size(); kk++) {
      // std::cout << "derivative[" << kk << "] = " << derivative[kk] << "\t         ";

      var2 = derivative[kk];

      if (abs(var2) > spike) {
         spike = var2;
         bigindex = kk;
      }
      // n++;
      // if (n == 4) {
      //    std::cout << "\n";
      //    n = 0;
      // }
              
   }
   std::cout << "\n" << std::endl;

   std::cout << "\nspike = " << spike << "\tderivative index = " << bigindex << std::endl;
   if (derivative[bigindex] > 0) {
      std::cout << "derivative index = " << bigindex + 1 << std::endl;
      std::cout << "the magnitude of the 'point' = " << data[bigindex+1] << std::endl;
      std::cout << "frequency = " << freq[bigindex+1] << std::endl;
   }
   else if (derivative[bigindex] < 0) {
      std::cout << "derivative index = " << bigindex << std::endl;
      std::cout << "the magnitude of the 'point' = " << data[bigindex] << std::endl;
      std::cout << "frequency = " << freq[bigindex] << std::endl;
   }



   // what i need to do now:
   // - determine the peak data point in order to determine what frequency to notch out
   // - what is a fool proof way to figure this out?
   // - I also haven't figured out how to do this 
   // - wb notches with some bandwidth?
   // - also how do I do this method in order to detect multiple peaks?
   //
   //
   // derivative threshold?



   // for (int ll=1730; ll<1750; ll++) {
   //    std::cout << "derivative[" << ll << "] = " << derivative[ll] << "       \t";
   //    std::cout << "data[" << ll << "] = " << data[ll] << std::endl;
   // }
   
   std::cout << "\nprogram finished" << std::endl;

   // plt::plot(freq, data); 
   // plt::xlabel("frequency");
   // plt::ylabel("magnitude");
   // plt::show();

   return 0;
} 