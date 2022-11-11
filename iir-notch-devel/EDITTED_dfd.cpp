
// g++ digital_filter_design.cpp -o t -I/usr/include/python3.8 -lpython3.8
// https://medium.com/geekculture/digital-filter-design-in-python-and-c-4484b6d6f4a5

#include <iostream>
#include <vector>
#include <tuple>
#include <complex>

#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

//------------------------------------------------------------------

std::tuple<std::vector<float>, std::vector<float>> computeTestSignal() {

    std::vector<float> tt;
    std::vector<float> yy;

    float A1{2.0};
    float A2{0.2};

    float f1{2.0};
    float f2{1500.0};

    int size = 8000;
    float dt = 1.0 / size;
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

void plot2(std::vector<std::complex<float>> signalIN) {

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

    std::vector<std::complex<float>> outputNyquist;

    // for(int ii = 0; ii<N/4; ii++){
    //      outputNyquist.push_back(output[ii]);
    // }
    // return outputNyquist;
    return output;
}

//------------------------------------------------------------------

std::vector<std::complex<float>> notchFilter(std::tuple<std::vector<float>, std::vector<float>> testSignal) {

    std::vector<float> tt = std::get<0>(testSignal);
    std::vector<float> yy = std::get<1>(testSignal);

    //implementation of Notch filter

    //filter
    std::vector<float> yy_filtered(yy.size(), 0.0);

    // float a1 = 1.37624044; // original coeffiecients
    // float a2 = -0.44587111;
    // float b0 = 0.73401885;
    // float b1 = -1.37624044;
    // float b2 = 0.71185226;

    // float a1 = -1.88728999; // my python generated coeffiecients --> is it because of the forward backward filtering thing? gonna try different coefficients
    // float a2 = 0.98441413;
    // float b0 = 0.99220706;
    // float b1 = -1.88728999;
    // float b2 = 0.99220706;

    float a1 = -0.735311; // my new coeffiecients
    float a2 =  0.923002;
    float b0 =  0.961979;
    float b1 = -0.736267;
    float b2 =  0.961979;

    for (int ii = 3; ii < yy.size(); ii++) { // *** THIS THIS THIS 
        yy_filtered[ii] = b0 * yy[ii] + b1 * yy[ii - 1] + b2 * yy[ii - 2] - a1 * yy_filtered[ii - 1] - a2 * yy_filtered[ii - 2];
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

    // Notch filter
    std::tuple<std::vector<float>, std::vector<float>> testNotchSignal = computeTestSignal();
    std::vector<std::complex<float>> filteredNotchSignal = notchFilter(testNotchSignal);
    std::vector<std::complex<float>> signalFilteredNotchDFT = computeDFT(filteredNotchSignal);
    plot2(signalFilteredNotchDFT);
}