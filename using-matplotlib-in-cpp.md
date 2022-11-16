## How to Install/Compile with the Matplotlib Library for C++

This is what worked for me because what was on the [matplotlib repo](https://github.com/lava/matplotlib-cpp) wasn't quite working for me.

1. [using matplotlibcpp to display figures in WSL2](https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj)

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
     ls /usr/include/python3.8                               // to check if the python3-dev library was installed, there should be lots of header files here
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