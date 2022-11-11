# IIR Notch Filter Notes and a Little More  <!-- omit in toc -->
### by: Grace Palenapa <!-- omit in toc -->
### updated 10.12.2022 <!-- omit in toc -->

---------------------

## table of contents <!-- omit in toc -->
- [introduction](#introduction)
- [current tasks 10.14.2022](#current-tasks-10142022)
- [complex signals](#complex-signals)
- [digital iir notch filter](#digital-iir-notch-filter)
- [conclusion about the iir notch filters](#conclusion-about-the-iir-notch-filters)
  - [10.12.2022](#10122022)
  - [10.13.2022](#10132022)
- [how to install/compile with the matplotlib library for c++](#how-to-installcompile-with-the-matplotlib-library-for-c)
- [reference links](#reference-links)

------------------------------

## introduction 

## current tasks 10.14.2022
- $I = 200cos(2*\pi ft + dt)$
- $Q = 200sin(2*\pi ft + dt)$
- use standard complex data type for the input [I,Q] data
- filter these signals
- the weight data signal is what's going to be filtered
- eventually I'll have to detect the interfering frequency filter it and then something else
- do the example

- design an iir notch filter based on notch frequency, notch depth/attenuation, bandwidth (anything else?)
- try modelling the iir notch filter after that matlab youtube video


```
// compare filter array results

// python results
// [ 0.99220706 -1.88728999  0.99220706] = b
// [ 1.         -1.88728999  0.98441413] = a

// my c++ results : pretty close!
// b_notch[0] = 0.992207   a_notch[0] = 1
// b_notch[1] = -1.88729   a_notch[1] = -1.90211
// b_notch[2] = 0.992207   a_notch[2] = 1

// editted samp_freq, notch_freq, quality_factor below

// my c++ results 10.14.2022 - NotchOut, 
// b_arr[0] = 0.998745     a_arr[0] = 1
// b_arr[1] = -1.98174     a_arr[1] = -1.98423
// b_arr[2] = 0.998745     a_arr[2] = 1

// my c++ results 10.14.2022 - pointer
// b_arr[0] = 0.998745     a_arr[0] = 1
// b_arr[1] = -1.98174     a_arr[1] = -1.98423
// b_arr[2] = 0.998745     a_arr[2] = 1

// python ---> all good!
// [ 0.99874494 -1.98173907  0.99874494]
// [ 1.         -1.98173907  0.99748988]
```

## complex signals

- analog complex signal $x(t) = x_R(t) + jx_I(t)$
- digital complex signal $x(n) = x_R(n) + jx_I(n)$

## digital iir notch filter

- IIR = "infinite impulse response" 

> Research [ 17 ,20 ] tries to utilize a notch filter as a computationally efficient solution for protecting the GNSS system against narrowband attacks. `One of the most important shortcomings of the notch filtering literature is the usage of a second-order or bi-polar notch filter. This type of notch has two symmetric gaps and can be applied to a real input signal.` This means that two bands of the input signal are removed by the filter. Telecommunication signals have “in-phase” and “quadrature” components that make the receiver able to work properly with both components as a complex number. `Working with complex numbers allows the system to use complex filters.` Compressed digital communication signal like DVB-S2, carries significant information in a narrow frequency band. This paper tries to utilize a first-order notch filter that has only one gap to preserve the quality of service as much as possible.

> The effective way to solve this problem is to high order IIR digital filter is simplified as several 2 order filter design, which adopts the cascade structure. So the system function: H(z)=H1(z)H2(z)...Hn(z)

## conclusion about the iir notch filters

###  10.12.2022

You can use the second-order IIR digital notch filter to filter complex input signals. According to the papers links below, a second-order notch filter transfer function has real coefficients (cosine function). I think this handles/filters the real part of the input signal. You could possibly use calculate the coefficients of the transfer function for a separate notch filter that handles the imaginary part. How to do this? Mmm I don't know.

### 10.13.2022

additional note from Josh: it should be fine. just test it later and focus on the getting the cpp code up and running.

## how to install/compile with the matplotlib library for c++

this is what worked for me because what was on the [matplotlib repo](https://github.com/lava/matplotlib-cpp) wasn't quite working for me.

1. [using matplotlibcpp to display figures in WSL2](https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj)
     I used this exact tutorial and it works for me. I'll rehash the steps I took to do this. 

     1. Download and run the [VcXsrv installer](https://sourceforge.net/projects/vcxsrv/). Make sure when you run the installation wizard you check the *Disable access control* box so you avoid permission issues later. Make sure you save the configuration, and then click __Finish__ when you're done.

     2. Upon clicking the __Finish__ button, a Windows Firewall pop-up should appear. Enable permissions for both private and public networks.
          > If the pop-up doesn't appear, or if you gave it the wrong permissions by mistake, you can just change the permissions manually. To do so, open Windows Security app and go to Firewall & network protection -> Allow an app through firewall and ensure VcXsrv windows x server has both permissions.

     3. Go to the WSL2 terminal in VSCode and open your __.bashrc__ script (I used the terminal command `code ~/.bashrc`).

     4. Add the one of the following lines of code to the bottom of your __.bashrc__ script (I used the first line).
          ```
          export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
          export DISPLAY="`sed -n 's/nameserver //p' /etc/resolv.conf`:0"
          export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0
          ```

     5. Use the terminal command `echo $DISPLAY` to check if the local IP address matches that in the `/etc/resolv.conf` file.

     6. Run the following command to install the VcXsrv apps: `sudo apt install x11-apps`

     7. Make sure VcXsrv is runnning. You can check this by looking for that icon in the bottom right corner of your screen. Test this by typing `xcalc` or `xeyes` in the terminal, and a separate window should pop up.
          > If you can't see any icon, just start the server by double-clicking on the config file you saved when installing. It will launch VcXsrv server with the configuration on that file. You can open the file with a text editor, if you want to check the configuration inside.

     8. You should now be able to use the matplotlib library and display figures.

     - ***NOTE: This set up should work for both C++ and Python programs***

2. Run the following commands: 
     ```
     python3 -m venv <name-of-your-environment>              // create an environment for your project
     source <path-to-environment-directory>/bin/activate     // activate the environment 
     pip3 install matplotlib                                 // installing  libraries
     sudo apt-get install python-numpy libpython3.8-dev
     ls /usr/local/include/python3.8                         // to check if the python3-dev library was installed, there should be lots of header files here
     ```
     - You can also use `python3.8-dev` besides `libpython3.8-dev`. I think it's the same thing.

3. I downloaded the [matplotlib-cpp library](https://github.com/lava/matplotlib-cpp) on github by typing the followiung command into the terminal: `git clone https://github.com/lava/matplotlib-cpp.git`
     - You just need to include `matplotlibcpp.h` in your program (and make sure it's in the same directory as your program), so make sure you put the following code at the top of your program:
     ```
     #include "matplotlibcpp.h"
     namespace plt = matplotlibcpp;
     ```
     - Since you're using the library as a namespace, don't forget to use the `plt` prefix like how you use `std` prefix for certain functions.

4. To compile the program in WSL, type the following in the terminal:
     ```
     g++ <your-program>.cpp -std=c++11 -I/usr/include/python3.8 -lpython3.8 -o <your-executable-name>
     ```

5. Type `./<your-executable-name>` in the terminal to run your program.
    


------------------------------

## reference links

[Complex Signals](http://bme.elektro.dtu.dk/31610/notes/complex.signals.pdf)

[First-order IIR filter](https://www.youtube.com/watch?v=dlZn8lUSexA)   published date: Aug. 3, 2020

[Design an IIR Notch Filter to Denoise Signal using Python](https://www.geeksforgeeks.org/design-an-iir-notch-filter-to-denoise-signal-using-python/)

[def _design_notch_peak_filter](https://github.com/scipy/scipy/blob/2e5883ef7af4f5ed4a5b80a1759a45e43163bf3f/scipy/signal/_filter_design.py#L5035)

[Lecture 14: Notch Filters](http://www.isle.illinois.edu/speech_web_lg/coursematerials/ece401/fa2020/slides/lec14.pdf)

[Second-order filters](http://tuttle.merc.iastate.edu/ee230/topics/filters/second_order_intro.pdf)

[Notch Filters](https://www.sciencedirect.com/topics/engineering/notch-filters)

[Second-order IIR Notch Filter Design and implementation of digital signal processing system](5887.pdf)

[Time-Varying IIR Notch Filter with Reduced Transient Response Based on the Bézier Curve Pole Radius Variability](applsci-09-01309.pdf)

[Effects of Interference and Mitigation Using Notch Filter for the DVB-S2 Standard](telecom-01-00017-v2.pdf)

[DSP IIR Realtime C++ filter library](https://github.com/berndporr/iir1)

[How to use GUI apps in WSL2 (forwarding X server)](https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj)

[venv — Creation of virtual environments](https://docs.python.org/3/library/venv.html)
