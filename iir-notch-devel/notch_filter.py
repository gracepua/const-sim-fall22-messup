# https://www.geeksforgeeks.org/design-an-iir-notch-filter-to-denoise-signal-using-python/

from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

# Create/view notch filter
samp_freq = 1000 # Sample frequency (Hz)
notch_freq = 50.0 # Frequency to be removed from signal (Hz)
quality_factor = 20.0 # Quality factor

# Design a notch filter using signal.iirnotch
b_notch, a_notch = signal.iirnotch(notch_freq, quality_factor, samp_freq)
print(b_notch)
print(a_notch)

# Compute magnitude response of the designed filter
freq, h = signal.freqz(b_notch, a_notch, fs=samp_freq)

fig = plt.figure(figsize=(8, 6))

# Plot magnitude response of the filter
plt.plot(freq*samp_freq/(2*np.pi), 20 * np.log10(abs(h)),
		'r', label='Bandpass filter', linewidth='2')
plt.xlabel('Frequency [Hz]', fontsize=20)
plt.ylabel('Magnitude [dB]', fontsize=20)
plt.title('Notch Filter', fontsize=20)
plt.grid()

# Create and view signal that is a mixture of two different frequencies
f1 = 15 # Frequency of 1st signal in Hz
f2 = 50 # Frequency of 2nd signal in Hz
# Set time vector
n = np.linspace(0, 1, 1000) # Generate 1000 sample sequence in 1 sec

# Generate the signal containing f1 and f2
noisySignal = np.sin(2*np.pi*15*n) + np.sin(2*np.pi*50*n) + \
	np.random.normal(0, .1, 1000)*0.03

# Plotting
fig = plt.figure(figsize=(8, 6))
plt.subplot(211)
plt.plot(n, noisySignal, color='r', linewidth=2)
plt.xlabel('Time', fontsize=20)
plt.ylabel('Magnitude', fontsize=18)
plt.title('Noisy Signal', fontsize=20)

# Apply notch filter to the noisy signal using signal.filtfilt
outputSignal = signal.filtfilt(b_notch, a_notch, noisySignal)

# Plot notch-filtered version of signal
plt.subplot(212)

# Plot output signal of notch filter
plt.plot(n, outputSignal)
plt.xlabel('Time', fontsize=20)
plt.ylabel('Magnitude', fontsize=18)
plt.title('Filtered Signal', fontsize=20)
plt.subplots_adjust(hspace=0.5)
fig.tight_layout()
plt.show()



# # https://github.com/scipy/scipy/blob/v1.9.1/scipy/signal/_filter_design.py#L4875-L4952 

# def iirnotch(w0, Q, fs=2.0):
#     """
#     Design second-order IIR notch digital filter.
#     A notch filter is a band-stop filter with a narrow bandwidth
#     (high quality factor). It rejects a narrow frequency band and
#     leaves the rest of the spectrum little changed.
#     Parameters
#     ----------
#     w0 : float
#         Frequency to remove from a signal. If `fs` is specified, this is in
#         the same units as `fs`. By default, it is a normalized scalar that must
#         satisfy  ``0 < w0 < 1``, with ``w0 = 1`` corresponding to half of the
#         sampling frequency.
#     Q : float
#         Quality factor. Dimensionless parameter that characterizes
#         notch filter -3 dB bandwidth ``bw`` relative to its center
#         frequency, ``Q = w0/bw``.
#     fs : float, optional
#         The sampling frequency of the digital system.
#         .. versionadded:: 1.2.0
#     Returns
#     -------
#     b, a : ndarray, ndarray
#         Numerator (``b``) and denominator (``a``) polynomials
#         of the IIR filter.
#     See Also
#     --------
#     iirpeak
#     Notes
#     -----
#     .. versionadded:: 0.19.0
#     References
#     ----------
#     .. [1] Sophocles J. Orfanidis, "Introduction To Signal Processing",
#            Prentice-Hall, 1996
#     Examples
#     --------
#     Design and plot filter to remove the 60 Hz component from a
#     signal sampled at 200 Hz, using a quality factor Q = 30
#     >>> from scipy import signal
#     >>> import matplotlib.pyplot as plt
#     >>> fs = 200.0  # Sample frequency (Hz)
#     >>> f0 = 60.0  # Frequency to be removed from signal (Hz)
#     >>> Q = 30.0  # Quality factor
#     >>> # Design notch filter
#     >>> b, a = signal.iirnotch(f0, Q, fs)
#     >>> # Frequency response
#     >>> freq, h = signal.freqz(b, a, fs=fs)
#     >>> # Plot
#     >>> fig, ax = plt.subplots(2, 1, figsize=(8, 6))
#     >>> ax[0].plot(freq, 20*np.log10(abs(h)), color='blue')
#     >>> ax[0].set_title("Frequency Response")
#     >>> ax[0].set_ylabel("Amplitude (dB)", color='blue')
#     >>> ax[0].set_xlim([0, 100])
#     >>> ax[0].set_ylim([-25, 10])
#     >>> ax[0].grid(True)
#     >>> ax[1].plot(freq, np.unwrap(np.angle(h))*180/np.pi, color='green')
#     >>> ax[1].set_ylabel("Angle (degrees)", color='green')
#     >>> ax[1].set_xlabel("Frequency (Hz)")
#     >>> ax[1].set_xlim([0, 100])
#     >>> ax[1].set_yticks([-90, -60, -30, 0, 30, 60, 90])
#     >>> ax[1].set_ylim([-90, 90])
#     >>> ax[1].grid(True)
#     >>> plt.show()
#     """

#     return _design_notch_peak_filter(w0, Q, "notch", fs)

# def _design_notch_peak_filter(w0, Q, ftype, fs=2.0):
#     """
#     Design notch or peak digital filter.
#     Parameters
#     ----------
#     w0 : float
#         Normalized frequency to remove from a signal. If `fs` is specified,
#         this is in the same units as `fs`. By default, it is a normalized
#         scalar that must satisfy  ``0 < w0 < 1``, with ``w0 = 1``
#         corresponding to half of the sampling frequency.
#     Q : float
#         Quality factor. Dimensionless parameter that characterizes
#         notch filter -3 dB bandwidth ``bw`` relative to its center
#         frequency, ``Q = w0/bw``.
#     ftype : str
#         The type of IIR filter to design:
#             - notch filter : ``notch``
#             - peak filter  : ``peak``
#     fs : float, optional
#         The sampling frequency of the digital system.
#         .. versionadded:: 1.2.0:
#     Returns
#     -------
#     b, a : ndarray, ndarray
#         Numerator (``b``) and denominator (``a``) polynomials
#         of the IIR filter.
#     """

#     # Guarantee that the inputs are floats
#     w0 = float(w0)
#     Q = float(Q)
#     w0 = 2*w0/fs

#     # Checks if w0 is within the range
#     if w0 > 1.0 or w0 < 0.0:
#         raise ValueError("w0 should be such that 0 < w0 < 1")

#     # Get bandwidth
#     bw = w0/Q

#     # Normalize inputs
#     bw = bw*np.pi
#     w0 = w0*np.pi

#     # Compute -3dB attenuation
#     gb = 1/np.sqrt(2)

#     if ftype == "notch":
#         # Compute beta: formula 11.3.4 (p.575) from reference [1]
#         beta = (np.sqrt(1.0-gb**2.0)/gb)*np.tan(bw/2.0)
#     elif ftype == "peak":
#         # Compute beta: formula 11.3.19 (p.579) from reference [1]
#         beta = (gb/np.sqrt(1.0-gb**2.0))*np.tan(bw/2.0)
#     else:
#         raise ValueError("Unknown ftype.")

#     # Compute gain: formula 11.3.6 (p.575) from reference [1]
#     gain = 1.0/(1.0+beta)

#     # Compute numerator b and denominator a
#     # formulas 11.3.7 (p.575) and 11.3.21 (p.579)
#     # from reference [1]
#     if ftype == "notch":
#         b = gain*np.array([1.0, -2.0*np.cos(w0), 1.0])
#     else:
#         b = (1.0-gain)*np.array([1.0, 0.0, -1.0])
#     a = np.array([1.0, -2.0*gain*np.cos(w0), (2.0*gain-1.0)])

#     return b, a