/* 
 * 
 * Author: Grace Palenapa
 * Revision Date: 11.15.2022
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
 * - (11/14) we can set the noise floor so this'll make finding peaks a bit easier
 *    - how to make this work for broad band signals?
 *    - current result when noise floor is given ( in this case, noise floor = -43dB, threshold requirement = -43 + 8 = -35dB)
 *    - the following result is from the previous github commit (the less complicated version ig)
 *
 * reading values from the .bin file... 
 *
 * mean = 0 / 4096 = -43
 * threshold = mean + 8dB = -35
 *
 * data point 411 pushed to peak list, mag = -16.3694
 *      (data[411] = -16.3694) - (threshold = -35) = 18.6306
 *        bandwidth = freq[441] - freq[378] = -1.9618e+07 - -2.03869e+07 = 768852
 *
 * data point 455 pushed to peak list, mag = -34.8657
 *        (data[455] = -34.8657) - (threshold = -35) = 0.134338
 *                doesn't meet threshold requirement
 *        bandwidth = freq[455] - freq[455] = -1.94472e+07 - -1.94472e+07 = 0
 *
 * data point 1967 pushed to peak list, mag = -15.2028
 *        (data[1967] = -15.2028) - (threshold = -35) = 19.7972
 *        bandwidth = freq[1975] - freq[1961] = -897100 - -1.06796e+06 = 170856
 *
 * data point 2176 pushed to peak list, mag = -15.0444
 *        (data[2176] = -15.0444) - (threshold = -35) = 19.9556
 *        bandwidth = freq[2186] - freq[2159] = 1.67794e+06 - 1.34844e+06 = 329508
 *
 * data point 2459 pushed to peak list, mag = -16.3681
 *        (data[2459] = -16.3681) - (threshold = -35) = 18.6319
 *        bandwidth = freq[2495] - freq[2419] = 5.44898e+06 - 4.52148e+06 = 927504
 *
 * data point 2868 pushed to peak list, mag = -15.4431
 *        (data[2868] = -15.4431) - (threshold = -35) =  = 19.5569
 *        bandwidth = freq[2884] - freq[2849] = 1.01963e+07 - 9.7692e+06 = 427140
 *
 * size of peak_index vector = 6
 *
 *        magnitude             frequency
 *
 *        -16.3694              -1.99842e+07
 *        -34.8657              -1.94472e+07
 *        -15.2028              -994732
 *        -15.0444              1.5559e+06
 *        -16.3681              5.00964e+06
 *        -15.4431              1.00011e+07
 * 
 * - (11/15) need a better way to determine peaks?
 */

#include <iostream>
#include <fstream>
#include <vector>
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() {
   std::fstream readFile("simulation_data/narrowBandNoiseOne.bin", std::ios::binary); //narrowBandNoiseOne
   float var, dif_index, sum = 0, threshold;
   std::vector<float> data; 
   std::vector<double> freq;
   std::vector<int> abv_threshold_index, peak_index;


   // 1. set the frequency array
   double ff = -25000000;
   for (int ii=0; ii<4096; ii++) {
      freq.push_back(ff);
      ff = ff + 12204;
   }


   // 2. read the psd.bin file and store the psd values
   readFile.open("simulation_data/narrowBandNoiseOne.bin"); // reading from bin file: successful!
   if(!readFile) {
      std::cout << "(r)Cannot open file!" << std::endl;
      return 1;
   }
   std::cout << "\nreading values from the .bin file..." << std::endl;
   
   int count = 0, n = 0;
   while (true) { // note: don't use .eof() function. use this loop format
      readFile.read((char*)&var, 4);
      if( readFile.eof() ) break;

      data.push_back(var);  // finding the sum of all the data magnitudes
      // sum += var;
   }
   readFile.close();


   // 3. find noise floor and threshold
   // threshold = sum / data.size();
   threshold = -43;
   std::cout << "\nmean = " << sum << " / " << data.size() << " = " << threshold << std::endl;
   threshold += 8;
   std::cout << "threshold = mean + 8dB = " << threshold << std::endl;


   // 4. find the values above the threshold 
   for (int jj=0; jj<data.size(); jj++) {
      if (data[jj] > threshold){
         abv_threshold_index.push_back(jj);
      }
   }

   


   // 5. determine the peaks in each data point subset   100000 Hz = 0.1 MHz
   //    - each subset is determined as following        122040
   //       - find the frequency difference between the current and the next data point (neighbors)
   //       - if the frequency difference is more than 122040
   float greatest = data[abv_threshold_index[0]], bandwidth = 0;
   int greatest_index = 0, current_data_index, start_index = abv_threshold_index[0], end_index;
   float slopeb1, slopeb2, slopeb3, slopeb4, slopeb5, slopea1, slopea2, slopea3, slopea4, slopea5;

   for (int ll=0; ll<abv_threshold_index.size(); ll++) { 
      current_data_index = abv_threshold_index[ll];
      dif_index = abv_threshold_index[ll+1] - abv_threshold_index[ll];

      if (data[current_data_index] > greatest) { // finding the greatest magnitude in each subset, this kind of works
         greatest = data[current_data_index]; 
         greatest_index = current_data_index;
      }

      // flag a possible peak
      if ( ((data[current_data_index] - data[current_data_index-1]) >= 5) && ((data[current_data_index+1] - data[current_data_index]) <= -5) ) {
         std::cout << "\nsharp peak detected at " << current_data_index << " 1 neighboring point" << std::endl;
         // if (slopeb1 > 0 && slopeb2 > 0 && slopeb3 > 0 && slopeb4 > 0 && slopeb5 > 0 && slopea1 < 0 && slopea2 < 0 && slopea3 < 0 && slopea4 < 0 && slopea5 < 0) {
         //    std::cout << "\tthis could definitely be a peak" << std::endl;
         //    possible_peak.push_back(current_data_index);
         // }
         // else std::cout << "not a peak" << std::endl;
      }

      if (ll == abv_threshold_index.size()-1 || dif_index > 10) {  // if the current data point is more than 10 points away from the next point in the main dataset, then you're at the end of the peak subset
         std::cout << "\nchecking data point " << greatest_index << " for peak list, mag = " << data[greatest_index] << std::endl;
         std::cout << "\t(data[" << greatest_index << "] = " << data[greatest_index] << ") - (threshold = " << threshold 
                   << ") = " << data[greatest_index] - threshold << std::endl;
         
         // std::cout << "\tdif_index = " << dif_index << "\tabv_threshold_index[ll+1]] = " << abv_threshold_index[ll+1] << std::endl;
         // std::cout << "\t(ll == abv_threshold_index.size()-1) = " << (ll == abv_threshold_index.size()-1) << std::endl;
         // std::cout << "\tindex ll = " << ll << "\tcurrent_data_index = " << current_data_index << std::endl;
         // std::cout << "\t((data[greatest_index] - threshold) < 5) = " << ((data[greatest_index] - threshold) < 5) << std::endl;

         if ((data[greatest_index] - threshold) < 5) {
            if (ll == abv_threshold_index.size()-1) continue; 

            greatest = data[abv_threshold_index[ll+1]];
            greatest_index = abv_threshold_index[ll+1];
            continue; // this'll pass the following commands and then go back to the beginning of the for loop
         }

         end_index = current_data_index;
         bandwidth = freq[end_index] - freq[start_index];
         std::cout << "\tbandwidth = freq[" << end_index<< "] - freq[" << start_index << "] = " << freq[end_index] 
                   << " - " << freq[start_index] <<  " = " << bandwidth << std::endl;
         start_index = abv_threshold_index[ll+1];

         // if (bandwidth > 200000) { // this needs to be slightly editted bc the notches are good but the bandwidth is throwing the program off
         //    if (ll == abv_threshold_index.size()-1) continue;

         //    greatest = data[abv_threshold_index[ll+1]];
         //    greatest_index = abv_threshold_index[ll+1];
         //    continue; //  
         // }

         // verify peak in this section
         slopeb1 = data[greatest_index]   - data[greatest_index-1];
         slopeb2 = data[greatest_index-1] - data[greatest_index-2];
         slopeb3 = data[greatest_index-2] - data[greatest_index-3];
         slopeb4 = data[greatest_index-3] - data[greatest_index-4];
         slopeb5 = data[greatest_index-4] - data[greatest_index-5];

         slopea1 = data[greatest_index+1] - data[greatest_index];
         slopea2 = data[greatest_index+2] - data[greatest_index+1];
         slopea3 = data[greatest_index+3] - data[greatest_index+2];
         slopea4 = data[greatest_index+4] - data[greatest_index+3];
         slopea5 = data[greatest_index+5] - data[greatest_index+4];

         std::cout << "\tslopeb5 < 0 => " << (slopeb5 > 0) << std::endl;
         std::cout << "\tslopeb4 < 0 => " << (slopeb4 > 0) << std::endl;
         std::cout << "\tslopeb3 < 0 => " << (slopeb3 > 0) << std::endl;
         std::cout << "\tslopeb2 < 0 => " << (slopeb2 > 0) << std::endl;
         std::cout << "\tslopeb1 < 0 => " << (slopeb1 > 0) << std::endl;
         std::cout << "\tslopea1 > 0 => " << (slopea1 < 0) << std::endl;
         std::cout << "\tslopea2 > 0 => " << (slopea2 < 0) << std::endl;
         std::cout << "\tslopea3 > 0 => " << (slopea3 < 0) << std::endl;
         std::cout << "\tslopea4 > 0 => " << (slopea4 < 0) << std::endl;
         std::cout << "\tslopea5 > 0 => " << (slopea5 < 0) << std::endl;

         peak_index.push_back(greatest_index);
         std::cout << "\t\tdone pushing the index to the vector" << std::endl;

         if (ll == abv_threshold_index.size()-1) continue; // if the end of the abv_threshold_index vector, exit the for loop
         greatest = data[abv_threshold_index[ll+1]];
         greatest_index = abv_threshold_index[ll+1];
      }
   }



   // 6. print the result vector
   std::cout << "\nsize of peak_index vector = " << peak_index.size() << std::endl;
   std::cout << "\n\tmagnitude\t      frequency\n" << std::endl;
   for (int mm=0; mm<peak_index.size(); mm++) {
      std::cout << "\t" << data[peak_index[mm]] << "\t      " << freq[peak_index[mm]] << std::endl;
   }

   // maybe find the magnitude difference of [immediate] neighboring points, then 
   // add the previous slopes together and then next slopes
   // if the sum of the preiouvs/next slops is greater than 3dB, then its probably a notch peak?

   // the expected result of step 6 for psdFourFloat.bin
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

// // 5. determine the peaks in each data point subset
//    //    - each subset is determined as following
//    //       - find the frequency difference between the current and the next data point (neighbors)
//    //       - if the frequency difference is less than -122040
//    greatest = data[abv_threshold_index[0]];
//    int greatest_index = abv_threshold_index[0], current_data_index;
//    // double bandwidth;
//    // int start = abv_threshold_index[0], end;
//    float slopeb1, slopeb2, slopeb3, slopeb4, slopeb5, slopea1, slopea2, slopea3, slopea4, slopea5;
//    std::vector<int> possible_peak;

//    // std::cout << "\n\tmagnitude\tfrequency\t\tdata index\tfreq dif\tmag dif\n" << std::endl; // checking the peak vectors
//    for (int kk=0; kk<abv_threshold_index.size(); kk++) { 
//       current_data_index = abv_threshold_index[kk];
//       dif_index = abv_threshold_index[kk+1] - abv_threshold_index[kk]; 

//       // std::cout << "\tslopeb5 < 0 => " << (slopeb5 > 0) << std::endl;
//       // std::cout << "\tslopeb4 < 0 => " << (slopeb4 > 0) << std::endl;
//       // std::cout << "\tslopeb3 < 0 => " << (slopeb3 > 0) << std::endl;
//       // std::cout << "\tslopeb2 < 0 => " << (slopeb2 > 0) << std::endl;
//       // std::cout << "\tslopeb1 < 0 => " << (slopeb1 > 0) << std::endl;
//       // std::cout << "\tslopea1 > 0 => " << (slopea1 < 0) << std::endl;
//       // std::cout << "\tslopea2 > 0 => " << (slopea2 < 0) << std::endl;
//       // std::cout << "\tslopea3 > 0 => " << (slopea3 < 0) << std::endl;
//       // std::cout << "\tslopea4 > 0 => " << (slopea4 < 0) << std::endl;
//       // std::cout << "\tslopea5 > 0 => " << (slopea5 < 0) << std::endl; 

//       // std::cout << "\tslopeb1 = " << slopeb1 << std::endl;
//       // std::cout << "\tslopeb2 = " << slopeb2 << std::endl;
//       // std::cout << "\tslopeb3 = " << slopeb3 << std::endl;
//       // std::cout << "\tslopeb4 = " << slopeb4 << std::endl;
//       // std::cout << "\tslopeb5 = " << slopeb5 << std::endl;
//       // std::cout << "\tslopea1 = " << slopea1 << std::endl;
//       // std::cout << "\tslopea2 = " << slopea2 << std::endl;
//       // std::cout << "\tslopea3 = " << slopea3 << std::endl;
//       // std::cout << "\tslopea4 = " << slopea4 << std::endl;
//       // std::cout << "\tslopea5 = " << slopea5 << std::endl;

      

//       // if the current data point is more than 10 points away from the next point in the main dataset, then you're at the end of the peak subset
//       if (dif_index > 10) {
//          peak_mag.push_back(data[greatest_index]);
//          peak_freq.push_back(freq[greatest_index]);
//          greatest = data[current_data_index+1]; // next data index listed in the abv_threshold_index
//          // greatest_index = 
         

         // // verify peak in this section
         // slopeb1 = data[greatest_index]   - data[greatest_index-1];
         // slopeb2 = data[greatest_index-1] - data[greatest_index-2];
         // slopeb3 = data[greatest_index-2] - data[greatest_index-3];
         // slopeb4 = data[greatest_index-3] - data[greatest_index-4];
         // slopeb5 = data[greatest_index-4] - data[greatest_index-5];

         // slopea1 = data[greatest_index+1] - data[greatest_index];
         // slopea2 = data[greatest_index+2] - data[greatest_index+1];
         // slopea3 = data[greatest_index+3] - data[greatest_index+2];
         // slopea4 = data[greatest_index+4] - data[greatest_index+3];
         // slopea5 = data[greatest_index+5] - data[greatest_index+4];

         // std::cout << "\tslopeb5 < 0 => " << (slopeb5 > 0) << std::endl;
         // std::cout << "\tslopeb4 < 0 => " << (slopeb4 > 0) << std::endl;
         // std::cout << "\tslopeb3 < 0 => " << (slopeb3 > 0) << std::endl;
         // std::cout << "\tslopeb2 < 0 => " << (slopeb2 > 0) << std::endl;
         // std::cout << "\tslopeb1 < 0 => " << (slopeb1 > 0) << std::endl;
         // std::cout << "\tslopea1 > 0 => " << (slopea1 < 0) << std::endl;
         // std::cout << "\tslopea2 > 0 => " << (slopea2 < 0) << std::endl;
         // std::cout << "\tslopea3 > 0 => " << (slopea3 < 0) << std::endl;
         // std::cout << "\tslopea4 > 0 => " << (slopea4 < 0) << std::endl;
         // std::cout << "\tslopea5 > 0 => " << (slopea5 < 0) << std::endl;

//          // if (slopeb1 > 0 && slopeb2 > 0 && slopeb3 > 0 && slopeb4 > 0 && slopeb5 > 0 && slopea1 < 0 && slopea2 < 0 && slopea3 < 0 && slopea4 < 0 && slopea5 < 0) {
//          //    std::cout << "peak detected at index " << greatest_index << "\n" << std::endl;
//          //    peak_mag.push_back(data[greatest_index]); 
//          //    peak_freq.push_back(freq[greatest_index]);
//          //    // greatest = data[current_data_index+1];
//          // }
//          // else std::cout << "point " << greatest_index << " not a peak" << std::endl;
//          // // std::cout << "peak listed" << std::endl;
//          continue;
//       }
      
//       if ((data[current_data_index] > greatest) && ((data[current_data_index] - threshold) > 3)) { // finding the greatest magnitude in each subset, this kind of works
//          greatest = data[current_data_index];
//          greatest_index = current_data_index;

         // // flag a possible peak
         // if ( ((data[current_data_index] - data[current_data_index-1]) >= 5) && ((data[current_data_index+1] - data[current_data_index]) <= -5) ) {
         //    std::cout << "\tsharp peak detected at " << current_data_index << " 1 neighboring point => " << std::endl;
         //    // if (slopeb1 > 0 && slopeb2 > 0 && slopeb3 > 0 && slopeb4 > 0 && slopeb5 > 0 && slopea1 < 0 && slopea2 < 0 && slopea3 < 0 && slopea4 < 0 && slopea5 < 0) {
         //    //    std::cout << "\tthis could definitely be a peak" << std::endl;
         //    //    possible_peak.push_back(current_data_index);
         //    // }
         //    // else std::cout << "not a peak" << std::endl;
         // }
//       } 

      
//    } 
