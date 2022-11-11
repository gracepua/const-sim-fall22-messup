# Notes about the streamCombine9_1 IP 
## by: Grace Palenapa

---------------------------

- while building the peripheral in Vivado's IP packager, the fifo generator's outputs must be generated globally.
- you can ignore the critical file error when packaging the IP
- the outputs for the main project can be generated out-of-context
- there shouldn't be any timing issues if you do this? I thing this has only been an issue with the htg board

### how to use vitis

### links about iir filters

https://pysdr.org/content/filters.html
http://t-filter.engineerjs.com/
https://fiiir.com/
https://tomroelandts.com/articles/how-to-create-simple-band-pass-and-band-reject-filters
https://www.electrical4u.com/band-stop-notch-filter/
https://www.advsolned.com/iir-filters-practical-guide/
https://dspguru.com/dsp/faqs/iir/basics/
https://www.advsolned.com/implementing-biquad-iir-filters-with-the-asn-filter-designer-and-the-arm-cmsis-dsp-software-framework/#figure1
https://brianmcfee.net/dstbook-site/content/ch11-iir/UsingIIR.html
