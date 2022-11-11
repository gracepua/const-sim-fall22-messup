// https://github.com/scipy/scipy/blob/2e5883ef7af4f5ed4a5b80a1759a45e43163bf3f/scipy/signal/_filter_design.py#L5035
// C++ translation of python notch filter
// Author: Grace Palenapa
// Revision Data: 10.14.2022
// Company: IS4S Auburn

#include <iostream>
#include <stdio.h>     
#include <math.h>       // sin,pow
#include <ctime>        // srand,rand
#include <random>
#include <tuple>
#include <complex>
#include <vector>

#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

//------------------------------------------------------------------

float* irrnotchCoefficients(float _f0, float _fs, float _Q) { 

    // float _f0    : notch frequency in Hz
    // float _zeta  : damping ratio
    // float _a     : bandwidth of notch frequency reponse in Hz (ratio away from the natural frequency or the width of the notch)

    // float r;            // radius on the pole 
    // float theta; 
    // float gain;
    // float bandwidth;    // in Hz, this is determined by the quality factor above, probably easier 
    //                     // to just state that in the beginning
    // static float coefficients[6];

    // coefficients[0] = 1.0;               // b_array, numerator coefficients
    // coefficients[1] = 2*_zeta*_f0;    
    // coefficients[2] = pow(_f0,2);

    // coefficients[3] = 1.0;               // a_array, denominator coeffiecients
    // coefficients[4] = _f0*(_a + (1/_a));
    // coefficients[5] = pow(_f0,2);

    float w0, bw, beta, gb, gain;
    static float coefficients[6];

    w0 = 2*_f0/_fs;

    // Checks if w0 is within the range
    if (w0 > 1.0 || w0 < 0.0) {
       std::cout << "w0 should be such that 0 < w0 < 1";
       return 0;
    }

    bw = w0/_Q;              // Get bandwidth - Q = how tight the notch is
    bw = bw*M_PI;           // Normalize inputs
    w0 = w0*M_PI;
    gb = 1/sqrt(2);         // Compute -3dB attenuation

    beta = (sqrt(1.0-pow(gb,2.0))/gb) * std::tan(bw/2.0);        // Compute beta: formula 11.3.4 (p.575) from reference [1]
    gain = 1.0/(1.0+beta);                                  // Compute gain: formula 11.3.6 (p.575) from reference [1]

    // Compute numerator b and denominator a
    // formulas 11.3.7 (p.575) and 11.3.21 (p.579)
    // from reference [1]
    coefficients[0] = gain * 1.0;               // b_array, numerator coefficients
    coefficients[1] = gain * -2.0*cos(w0);    
    coefficients[2] = gain * 1.0;

    coefficients[3] = 1.0;                      // a_array, denominator coeffiecients
    coefficients[4] = -2.0*gain*std::cos(w0);           
    coefficients[5] = 2.0*gain - 1.0;

    return coefficients;            
}

//------------------------------------------------------------------

int main() {

    float* notch_arr;  
    float notch_freq = 50;      // Frequency to be removed from signal (in Hz) or notch location
    float samp_freq  = 1000;    // Sample frequency (Hz)
    float quality_factor = 10;  // Quality factor
    float damping = 0.50;       // closer to 1 the damping ratio is, the deeper the notch depth
    float bandwidth  = 2;       // ratio away from the natural frequency or the width of the notch

    // notch_arr = irrnotchCoefficients(notch_freq, damping, bandwidth);
    notch_arr = irrnotchCoefficients(notch_freq, samp_freq, quality_factor);

    for (int i=0; i<3; i++) {
        std::cout << "b_arr[" << i << "] = " << *(notch_arr + i) << "\t";
        std::cout << "a_arr[" << i << "] = " << *(notch_arr + i + 3) << std::endl;
    }

    return 0;
}