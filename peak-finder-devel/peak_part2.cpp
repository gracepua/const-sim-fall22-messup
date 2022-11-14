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
   std::fstream readFile("simulation_data/psdFourFloat.bin", std::ios::binary);
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
   readFile.open("simulation_data/psdFourFloat.bin"); // reading from bin file: successful!
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
      sum += var;
   }
   readFile.close();


   // 3. find noise threshold
   threshold = sum / data.size();
   std::cout << "\n\nmean = " << sum << " / " << data.size() << " = " << threshold << std::endl;
   threshold += 6;
   std::cout << "threshold = mean + 6dB = " << threshold << std::endl;


   // 4. find the values above the threshold 
   for (int jj=0; jj<data.size(); jj++) {
      if (data[jj] > threshold){
         // std::cout << "\t" << data[jj] << "\t      " << freq[jj] << "\t" << jj << std::endl;
         abv_threshold_index.push_back(jj);
      }
   }

   
    // 5. determine the peaks in each data point subset
   //    - each subset is determined as following
   //       - find the frequency difference between the current and the next data point (neighbors)
   //       - if the frequency difference is less than -122040
   float greatest = data[abv_threshold_index[0]], bandwidth = 0;
   int greatest_index = 0, current_data_index, start_index = abv_threshold_index[0], end_index;

   for (int ll=0; ll<abv_threshold_index.size()-1; ll++) { 
      current_data_index = abv_threshold_index[ll];
      dif_index = abv_threshold_index[ll+1] - abv_threshold_index[ll];

      if ((data[current_data_index] > greatest) ) { // finding the greatest magnitude in each subset, this kind of works
         greatest = data[current_data_index]; //&& ((data[current_data_index] - threshold) > 3
         greatest_index = current_data_index;
      }

      if (dif_index > 10) {  // if the current data point is more than 10 points away from the next point in the main dataset, then you're at the end of the peak subset
         std::cout << "\ndata point " << greatest_index << " pushed to peak list, mag = " << data[greatest_index] << "\n" << std::endl;
         peak_index.push_back(greatest_index);
         greatest = data[abv_threshold_index[ll+1]];
         greatest_index = abv_threshold_index[ll+1];

         end_index = current_data_index;
         bandwidth = end_index - start_index;
         std::cout << "bandwidth = end_index - start_index = " << end_index << " - " << start_index <<  " = " << bandwidth << std::endl;
         start_index = abv_threshold_index[ll+1];
      }


      

   }
   peak_index.push_back(greatest_index);
   std::cout << "\npeak detected at index " << greatest_index << " last one"<< std::endl;
   std::cout << "greatest - threshold = " << greatest << " - " 
             << threshold << " = " << greatest - threshold << std::endl;
   
   // 6. print the result vector
   std::cout << "\nsize of peak_index vector = " << peak_index.size() << std::endl;
   std::cout << "\n\tmagnitude\t      frequency\n" << std::endl;
   for (int mm=0; mm<peak_index.size(); mm++) {
      std::cout << "\t" << data[peak_index[mm]] << "\t      " << freq[peak_index[mm]] << std::endl;
   }

   // maybe find the magnitude difference of [immediate] neighboring points, then 
   // add the previous slopes together and then next slopes
   // if the sum of the preiouvs/next slops is greater than 3dB, then its probably a notch peak?

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
         

//          // // verify peak in this section
//          slopeb1 = data[greatest_index]   - data[greatest_index-1];
//          slopeb2 = data[greatest_index-1] - data[greatest_index-2];
//          slopeb3 = data[greatest_index-2] - data[greatest_index-3];
//          slopeb4 = data[greatest_index-3] - data[greatest_index-4];
//          slopeb5 = data[greatest_index-4] - data[greatest_index-5];

//          slopea1 = data[greatest_index+1] - data[greatest_index];
//          slopea2 = data[greatest_index+2] - data[greatest_index+1];
//          slopea3 = data[greatest_index+3] - data[greatest_index+2];
//          slopea4 = data[greatest_index+4] - data[greatest_index+3];
//          slopea5 = data[greatest_index+5] - data[greatest_index+4];

//          std::cout << "\tslopeb5 < 0 => " << (slopeb5 > 0) << std::endl;
//          std::cout << "\tslopeb4 < 0 => " << (slopeb4 > 0) << std::endl;
//          std::cout << "\tslopeb3 < 0 => " << (slopeb3 > 0) << std::endl;
//          std::cout << "\tslopeb2 < 0 => " << (slopeb2 > 0) << std::endl;
//          std::cout << "\tslopeb1 < 0 => " << (slopeb1 > 0) << std::endl;
//          std::cout << "\tslopea1 > 0 => " << (slopea1 < 0) << std::endl;
//          std::cout << "\tslopea2 > 0 => " << (slopea2 < 0) << std::endl;
//          std::cout << "\tslopea3 > 0 => " << (slopea3 < 0) << std::endl;
//          std::cout << "\tslopea4 > 0 => " << (slopea4 < 0) << std::endl;
//          std::cout << "\tslopea5 > 0 => " << (slopea5 < 0) << std::endl;

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

//          // flag a possible peak
//          if ( ((data[current_data_index] - data[current_data_index-1]) >= 5) && ((data[current_data_index+1] - data[current_data_index]) <= -5) ) {
//             std::cout << "\tsharp peak detected at " << current_data_index << " 1 neighboring point => " << std::endl;
//             // if (slopeb1 > 0 && slopeb2 > 0 && slopeb3 > 0 && slopeb4 > 0 && slopeb5 > 0 && slopea1 < 0 && slopea2 < 0 && slopea3 < 0 && slopea4 < 0 && slopea5 < 0) {
//             //    std::cout << "\tthis could definitely be a peak" << std::endl;
//             //    possible_peak.push_back(current_data_index);
//             // }
//             // else std::cout << "not a peak" << std::endl;
//          }
//       } 

      
//    } 


/ // std::cout << ll << ". dif_index = " << dif_index << "\t mag = " << data[current_data_index] << std::endl;

      // if ((data[current_data_index] > greatest) && ((data[current_data_index] - threshold) > 3)) { // finding the greatest magnitude in each subset, this kind of works
      //    greatest = data[current_data_index];
      //    greatest_index = current_data_index;
      // }

      // if (dif_index > 10) {  // if the current data point is more than 10 points away from the next point in the main dataset, then you're at the end of the peak subset

      //    // slight error here there on psdThreeFloat.bin
      //    // should I check if the same point is already in the vector?

      //    // if (freq[greatest_index] == peak_freq.back()) std::cout << "the same freq/mag" << std::endl;

      //    if ((greatest - threshold) < 3) { // if this is point is just way too low then don't even bother
      //       std::cout << "greatest - threshold = " << greatest << " - " 
      //                 << threshold << " = " << greatest - threshold << std::endl;
      //       continue;
      //    }

      //    std::cout << "peak detected at index " << greatest_index << std::endl;
      //    std::cout << "\tgreatest - threshold = " << greatest << " - " 
      //              << threshold << " = " << greatest - threshold << std::endl;
      //    std::cout << "\t(greatest - threshold) > 3 = " << ((greatest - threshold) > 3) << std::endl;
      //    if (peak_index.empty() == 1 && (greatest - threshold) > 3) {
      //       std::cout << "\tfirst element: point " << greatest_index << std::endl;
      //       peak_index.push_back(greatest_index);
      //       greatest = data[current_data_index+1];
      //       greatest_index = abv_threshold_index[ll+1];
      //       continue;
      //    }   
         
      //    if (greatest_index == peak_index.back()) {
      //       std::cout << "\tthe same freq/mag" << std::endl;
      //       greatest = data[abv_threshold_index[ll+1]];
      //       greatest_index = abv_threshold_index[ll+1];
      //       continue;
      //    }

         // peak_index.push_back(greatest_index);
         // greatest = data[current_data_index+1];
         // greatest_index = abv_threshold_index[ll+1];

         // std::cout << "end of if statement" << std::endl;
      // }
   

      // // check immediate neighbors: 1 point away - if there's a sharp incline and decline at the current point, push that point to the peak vector
      // if ( ((data[current_data_index] - data[current_data_index-1]) >= 3) && ((data[current_data_index+1] - data[current_data_index]) <= -3) ) {
      //    std::cout << "\tsharp peak detected at " << current_data_index << " 1 neighboring point" << std::endl;
      //    // continue;
      // }

      // std::cout << "end of for loop" << std::endl;