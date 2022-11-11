from fxpmath import Fxp
import numpy as np


def main():

    # Calculate weight in floating point
    magnitude = 1
    phase = 45
    weightI = magnitude*np.cos(np.radians(phase))
    weightQ = magnitude*np.sin(np.radians(phase))
    print(weightI)
    print(weightQ)

    # Convert to fixed point
    fixedWeightI = Fxp(weightI, signed=True, n_word=25, n_frac=23)
    fixedWeightI.info(verbose=3)
    print(fixedWeightI)
    print(fixedWeightI.base_repr(2))

    fixedWeightQ = Fxp(weightI, signed=True, n_word=25, n_frac=23)
    fixedWeightQ.info(verbose=3)
    print(fixedWeightQ)
    print(fixedWeightQ.base_repr(2))


if __name__ == '__main__':
    main()