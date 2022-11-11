#include <iostream>
#include <stdio.h>     
#include <math.h>       /* sin */

#define PI 3.141592653589793238462643383279502884

template<size_t dp>
const int16_t FloattoFixed(float d) {
	return int16_t(d * float(1 << dp) + (d >= 0 ? 0.5 : -0.5));
}

// calcWeightPacket - calculate weight[Q,I] and returns a concatenated weight packet
//		input : float magnitude_ , float phase_
// 		return : int32_t
int32_t calcWeightPacket(float magnitude_, float phase_) {

	// calculate weight in floating point
	float I_float = magnitude_ * cos(phase_ * PI/180);
	float Q_float = magnitude_ * sin(phase_ * PI/180);
	// std::cout <<  I_float << "\t" << Q_float << std::endl;

	// convert float to fixed point S2_10
	int16_t I_fixed = FloattoFixed<10>(I_float);
	int16_t Q_fixed = FloattoFixed<10>(Q_float);

	// concat binary sequences to send to slave reg
    return (Q_fixed << 12) | I_fixed;   // [Q,I]
}


int main () {

	// Calculate weight in floating point
	float magnitude = 1, phase = 45;
    std::cout << calcWeightPacket(magnitude, phase) << std::endl;

	return 0;
}

// output: 1011010100 001011010100 (concatenated binary) = 2966228 (base 10)
// sqrt(2)/2 = 0.707107 (base 10) = 724 (fixed point binary) = 001011010100 (12 bits)