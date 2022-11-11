// https://github.com/scipy/scipy/blob/2e5883ef7af4f5ed4a5b80a1759a45e43163bf3f/scipy/signal/_filter_design.py//L5035
// C++ translation of python notch filter
// Author: Grace Palenapa
// Revision Data: 10.14.2022
// Company: IS4S Auburn

//include <iostream>
//include <stdio.h>     
//include <math.h>       // sin,pow
//include <ctime>        // srand,rand
//include <random>
//include <tuple>
//include <complex>
//include <vector>

//include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

//------------------------------------------------------------------

float* irrnotchCoefficients(float _f0, float _fs, float _bw, float _Q) { 

    // https://www.sciencedirect.com/topics/engineering/notch-filters
    // ^^ Infinite Impulse Response Filter Design
    //      8.7.2 Second-Order Bandstop (Notch) Filter Design

    // float _f0 : notch frequency in Hz
    // float _fs : sampling frequency in Hz
    // float _bw : bandwidth of notch frequency reponse in Hz

    float r;            // I've noticed the smaller r value 
    float theta; 
    float gain;
    float bandwidth;    // in Hz, this is determined by the quality factor above, probably easier 
                        // to just state that in the beginning
    static float coefficients[8];

    r = 1 - (_bw/_fs) * M_PI;
    theta = (_f0/_fs) * 2 * M_PI; // in radians 
    gain = (1 - 2*r*std::cos(theta) + pow(r,2)) / (2 - 2*std::cos(theta));  // gain = K in the website

    coefficients[0] = 1.0;               // b_array, numerator coefficients
    coefficients[1] = (-2.0*cos(theta));    
    coefficients[2] = 1.0;

    coefficients[3] = 1.0;                      // a_array, denominator coeffiecients
    coefficients[4] = -2.0*r*cos(theta);           
    coefficients[5] = pow(r,2);

    coefficients[6] = gain;    // just to see what the gain is
    coefficients[7] = r;

    return coefficients;            
}

//------------------------------------------------------------------

std::tuple<std::vector<float>, std::vector<float>> computeTestSignal(float _sampfreq) { // in the end I won't need this

    std::vector<float> tt;
    std::vector<float> yy;

    float A1{2.0};
    float A2{0.2};

    float f1{2.0};
    float f2{50.0};

    // int size = 1000;
    float dt = 1.0 / _sampfreq;
    float yyi;

    for (float t = 0.0; t <= 1.0; t = t + dt) {
        yyi = A1 * std::sin(2 * M_PI * f1 * t) + A2 * std::sin(2 * M_PI * f2 * t);
        // yyi = 5 * std::sin(2 * M_PI * 50 * t);
        tt.push_back(t);
        yy.push_back(yyi);
    }

    plt::plot(tt, yy);
    //plt::xlim(0, 1);

    plt::xlabel("time");
    plt::ylabel("amplitude");
    plt::show();

    return std::make_tuple(tt, yy);
}

//------------------------------------------------------------------

void plot2(std::vector<std::complex<float>> signalIN) { // ** eventually won't need this either

    int N = signalIN.size();
    std::vector<float> xx;
    std::vector<float> yy;

    for (int n = 0; n < N; n++) {
        xx.push_back(n);
    }

    for (auto &ii : signalIN) {
        ii = ii / static_cast<float>(N);
        yy.push_back(std::abs(ii));
    }

    plt::scatter(xx, yy);
    plt::xlim(0, 100);
    plt::plot(xx, yy);

    plt::xlabel("frequency");
    plt::ylabel("amplitude");
    plt::show();
}

//------------------------------------------------------------------

std::vector<std::complex<float>> computeDFT(std::vector<std::complex<float>> X) {

    int N = X.size();
    int K = N;

    std::vector<float> dft;
    std::vector<int> freq;

    std::complex<float> intSum;

    std::vector<std::complex<float>> output;
    output.reserve(K);

    for (int k = 0; k < K; k++) {
        intSum = std::complex<float>(0.0, 0.0);

        for (int n = 0; n < N; n++) {
            float realPart = std::cos((2 * M_PI / N) * k * n);
            float imagPart = std::sin((2 * M_PI / N) * k * n);

            std::complex<float> w(realPart, -imagPart);

            intSum += X[n] * w;
        }

        output.push_back(intSum);
    }

    // take half due tp Nyquist

    // std::vector<std::complex<float>> outputNyquist;

    // for(int ii = 0; ii<N/4; ii++){
    //      outputNyquist.push_back(output[ii]);
    // }
    // return outputNyquist;

    return output;
}

//------------------------------------------------------------------

std::vector<std::complex<float>> notchFilter(std::tuple<std::vector<float>, std::vector<float>> testSignal,
    float _b0, float _b1, float _b2, float _a1, float _a2) {

    std::vector<float> tt = std::get<0>(testSignal);
    std::vector<float> yy = std::get<1>(testSignal);

    //implementation of Notch filter

    //filter
    std::vector<float> yy_filtered(yy.size(), 0.0);

    for (int ii = 3; ii < yy.size(); ii++) { // *** THIS THIS THIS 
        yy_filtered[ii] = _b0 * yy[ii] + _b1 * yy[ii - 1] + _b2 * yy[ii - 2] - _a1 * yy_filtered[ii - 1] - _a2 * yy_filtered[ii - 2];
    }

    plt::plot(tt, yy_filtered);
    plt::xlabel("time");
    plt::ylabel("amplitude");

    plt::show();

    //output complex

    std::vector<std::complex<float>> outputCPX;

    for (auto &ii : yy_filtered) {
        auto outputCPXi = std::complex<float>(ii, 0.0);
        outputCPX.push_back(outputCPXi);
    }
    return outputCPX;
}

//------------------------------------------------------------------

int main() {

    float* notch_arr;  
    float samp_freq  = 1000;    // Sample frequency (Hz)
    float notch_freq = 50;    // Frequency to be removed from signal (Hz)
    float bandwidth = 100;      // in Hz
    // float quality_factor;       // Quality factor

    notch_arr = irrnotchCoefficients(notch_freq, samp_freq, bandwidth);
    for (int i=0; i<3; i++) {
        std::cout << "b_arr[" << i << "] = " << *(notch_arr + i) << "\t";
        std::cout << "a_arr[" << i << "] = " << *(notch_arr + i + 3) << std::endl;
    }

    std::cout << "unit-gain scale factor = " << *(notch_arr + 6) << std::endl;
    std::cout << "r = " << *(notch_arr + 7) << std::endl;

    float b0, b1, b2, a0, a1, a2;
    b0 = *(notch_arr);
    b1 = *(notch_arr + 1);
    b2 = *(notch_arr + 2);
    a0 = *(notch_arr + 3);
    a1 = *(notch_arr + 4);
    a2 = *(notch_arr + 5);

    std::tuple<std::vector<float>, std::vector<float>> testNotchSignal = computeTestSignal(samp_freq);
    std::vector<std::complex<float>> filteredNotchSignal = notchFilter(testNotchSignal, b0, b1, b2, a1, a2);
    std::vector<std::complex<float>> signalFilteredNotchDFT = computeDFT(filteredNotchSignal);
    plot2(signalFilteredNotchDFT);

    return 0;
}