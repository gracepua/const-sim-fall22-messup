/* 
 * 
 * Author: Grace Palenapa
 * Revision Date: 11.08.2022
 * 
 * read PSD.bin data file and find the peaks 
 *
 * Notes: 
 * - how it works
 *    1. set the frequency array
 *    2. read the psd.bin file and store the psd values
 *    3. find noise threshold => 8dB over the mean of data point magnitudes
 *    4. find the values above the threshold
 *    5. determine the peaks in each data point subset
 *       - each subset is determined as following:
 *          - find the frequency difference between the current and the next data point (neighbors)
 *          - if the frequency difference is less than -122040, that point indicates the end of a data subset
 *       - find the largest magnitude in each subset
 *    6. print the result vector
 *    7. display/graph the data
 * 
 * issues:
 * 
 * - (11/01) the psdFourFLoat.bin data file
 *    - there are super close peaks at 1MHz and 1.5MHz
 *    - this program is unable to detect these super close peaks
 *    - take the magnitude difference betweeen the points above the threshold?
 *       - if the neighboring point or the next one over is in between the data point subset [above the threshold],
 *         then take the derivative between those neighboring points anyway?
 * - (11/03) I'll worry about the whether i should use an array or vector later: my current thoughts
 *    - array: more efficient memory allocation, static array size
 *    - vector: less efficient memory allotcation, dynamic array size
 * - (11/03) maybe i just need the index and then just reference the data or frequency array with that
 * - (11/08) this doesn't work well to detect signals with bandwidth
 *    - maybe test the negative and positive slopes? 
 *    - for a peak to occur, the peak point must have positive slopes leading up to it and then negative slopes following
 */

#include <iostream>
#include <fstream>
#include <vector>
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() {
   std::fstream readFile("simulation_data/psdThreeFloat.bin", std::ios::binary);
   float var, var0, var1, dif_index, greatest, sum = 0, threshold;
   std::vector<float> data, abv_threshold_mag, peak_mag; // i guess these need to be vectors
   std::vector<double> freq, abv_threshold_freq, peak_freq, index_peak_freq;
   std::vector<int> abv_threshold_index, peak_index;

   // 1. set the frequency array
   double ff = -25000000;
   for (int ii=0; ii<4096; ii++) {
      freq.push_back(ff);
      ff = ff + 12204;
   }
   

   readFile.open("simulation_data/psdThreeFloat.bin"); // reading from bin file: successful!
   if(!readFile) {
      std::cout << "(r)Cannot open file!" << std::endl;
      return 1;
   }


   // 2. read the psd.bin file and store the psd values
   std::cout << "\nreading values from the .bin file..." << std::endl;

   readFile.read((char*)&var0, 4);
   sum += var0;
   data.push_back(var0);
   // std::cout << var0 << "     \t";
   
   int count = 1, n = 1;
   while (true) { // note: don't use .eof() function. use this loop format
      readFile.read((char*)&var1, 4);
      if( readFile.eof() ) break;

      data.push_back(var1);  // finding the sum of all the data magnitudes
      sum += var1;
      count++;

      // std::cout << var1 << "     \t";
      // n++;
      // if (n == 10) {
      //    std::cout << "\n";
      //    n = 0;
      // }
   }
   readFile.close();

   // 3. find noise threshold
   threshold = sum / count;
   std::cout << "\n\nmean = " << sum << " / " << count << " = " << threshold << std::endl;
   threshold += 6;
   std::cout << "threshold = mean + 6dB = " << threshold << std::endl;


   // 4. find the values above the threshold 
   for (int kk=0; kk<data.size(); kk++) {
      if (data[kk] > threshold){
         // std::cout << "\t" << data[kk] << "\t      " << freq[kk] << std::endl;
         abv_threshold_mag.push_back(data[kk]);
         abv_threshold_freq.push_back(freq[kk]);
         abv_threshold_index.push_back(kk);
      }
   }

   
   // 5. determine the peaks in each data point subset
   //    - each subset is determined as following
   //       - find the frequency difference between the current and the next data point (neighbors)
   //       - if the frequency difference is less than -122040
   greatest = abv_threshold_mag[0];
   int greatest_index = 0, current_data_index;
   double bandwidth;
   int start = abv_threshold_index[0], end;
   float dif_freq, dif_mag;

   std::cout << "\n\tmagnitude\tfrequency\t\tdata index\tfreq dif\tmag dif\n" << std::endl; // checking the peak vectors
   for (int ll=0; ll<abv_threshold_mag.size()-1; ll++) { 
      current_data_index = abv_threshold_index[ll];

      // dif_freq  = abv_threshold_freq[ll+1]  - abv_threshold_freq[ll];
      // dif_mag   = abv_threshold_mag[ll+1]   - abv_threshold_mag[ll];
      dif_index = abv_threshold_index[ll+1] - abv_threshold_index[ll]; 

      // std::cout << ll << "\t" << data[current_data_index] << "   \t" << freq[current_data_index];
      // std::cout << "\t\t" << current_data_index << "\t\t" << dif_freq << "\t      ";
      // std::cout << dif_mag  << "\t\tindex difference = " << dif_index;
      // std::cout << "\t\tderivative value = dif_mag/dif_freq = " << dif_mag/dif_freq << std::endl;

      if (dif_index > 10) {  // if the current data point is more than 10 points away from the next point in the main dataset, then you're at the end of the peak subset
         peak_mag.push_back(greatest);
         peak_freq.push_back(freq[greatest_index]);
         greatest = data[current_data_index+1];
         std::cout << "peak detected at index " << greatest_index << "\n" << std::endl;
      }
      
      if (abv_threshold_mag[ll] > greatest) { // finding the greatest magnitude in each subset, this kind of works
         greatest = data[current_data_index];
         greatest_index = current_data_index;
      }

      // // check immediate neighbors: 1 point away - if there's a sharp incline and decline at the current point, push that point to the peak vector
      // if ( ((data[current_data_index] - data[current_data_index-1]) >= 3) && ((data[current_data_index+1] - data[current_data_index]) <= -3) ) {
      //    std::cout << "\tsharp peak detected at " << current_data_index << " 1 neighboring point" << std::endl;
      //    // continue;
      // }

   }
   peak_mag.push_back(greatest); // get the last peak value in the vector
   peak_freq.push_back(freq[greatest_index]);
   std::cout << "\npeak detected at index " << greatest_index << " last one"<< std::endl;

   // std::cout << "size of abv_threshold_index = " << abv_threshold_mag.size() << std::endl; 
   
   // 6. print the result vector
   std::cout << "\nsize of peak_mag vector = " << peak_mag.size() << std::endl;
   std::cout << "\n\tmagnitude\t      frequency\n" << std::endl;
   for (int mm=0; mm<peak_mag.size(); mm++) {
      std::cout << "\t" << peak_mag[mm] << "\t      " << peak_freq[mm] << std::endl;
   }

   // the expected result of step 6 fro psdFourFloat.bin
   // magnitude             frequency

   // -16.3694              -1.99842e+07
   // -15.2028              -994732
   // -15.0444              1.5559e+06
   // -16.3681              5.00964e+06
   // -15.4431              1.00011e+07

   std::cout << "\nprogram finished\n" << std::endl;

   //  display the data
   plt::plot(freq, data);
   plt::axhline(threshold);
   plt::xlabel("frequency");
   plt::ylabel("magnitude");
   plt::show();

   return 0;
} 