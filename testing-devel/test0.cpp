#include <iostream>
#include <random>

#define PI 3.141592653589793238462643383279502884

int main() {

    // Create and view signal that is a mixture of two different frequencies
    float f1 = 1000000; // Frequency of 1st signal in Hz
    float f2 = 500000; // Frequency of 2nd signal in Hz

    // Generate the signal containing f1 and f2
    std::default_random_engine generator;
    std::normal_distribution<float> distribution(0,0.1);
    float noisySignal;

    // float num; 

    for (int j=0; j<5; j++) {
        float num = distribution(generator)*0.03;
        noisySignal = sin(2*PI*f1*j) + sin(2*PI*f2*j) + num; 
        std::cout << noisySignal << std::endl;
    }

    return 0;

}