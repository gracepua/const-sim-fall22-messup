clc;clear;close all;

fSamp = 50e6;
dt = 1/fSamp;
numSamp = 1024*4;
t = 0:dt:dt*(numSamp-1);

noiseI = 100*randn(1,length(t));
noiseQ = 100*randn(1,length(t));

noise = noiseI + 1i*noiseQ;

%% scenario One
freq = 1e6;
amp = 1000;
I = amp*cos(2*pi*freq*t);
Q = amp*sin(2*pi*freq*t);

outIQ = I + 1i*Q + noise;

psd = round(plot_psd(fSamp,outIQ));


fid = fopen("psdOneinteger.bin",'wb');
fwrite(fid,psd,"int16");
fclose(fid);



%% scenario Two
freq = -1e6;
amp = 1000;
I = amp*cos(2*pi*freq*t);
Q = amp*sin(2*pi*freq*t);

outIQ = I + 1i*Q + noise;

psd = round(plot_psd(fSamp,outIQ));


fid = fopen("psdTwointeger.bin",'wb');
fwrite(fid,psd,"int16");
fclose(fid);


%% scenario Three
freq = [-1e6 5e6];
amp = 1000;
outIQ = zeros(1,length(t));
for ii = 1:length(freq)
    I = amp*cos(2*pi*freq(ii)*t);
    Q = amp*sin(2*pi*freq(ii)*t);
    outIQ = outIQ + I + 1i*Q;

end

outIQ = outIQ + noise;

psd = round(plot_psd(fSamp,outIQ));


fid = fopen("psdThreeinteger.bin",'wb');
fwrite(fid,psd,"int16");
fclose(fid);

%% scenario Four
freq = [-1e6 5e6 1.5e6 10e6 -20e6 1.55e6];
amp = 1000;
outIQ = zeros(1,length(t));
for ii = 1:length(freq)
    I = amp*cos(2*pi*freq(ii)*t);
    Q = amp*sin(2*pi*freq(ii)*t);
    outIQ = outIQ + I + 1i*Q;

end

outIQ = outIQ + noise;

psd = round(plot_psd(fSamp,outIQ));


fid = fopen("psdFourinteger.bin",'wb');
fwrite(fid,psd,"int16");
fclose(fid);


%% Read PSDs

fid = fopen("psdOneinteger.bin",'r');
psd = fread(fid,4096,"int16");
fclose(fid);
figure()
subplot(2,2,1)
plot(psd)
grid on
title("PSD One")

fid = fopen("psdTwointeger.bin",'r');
psd = fread(fid,4096,"int16");
fclose(fid);
subplot(2,2,2)
plot(psd)
grid on
title("PSD Two")


fid = fopen("psdThreeinteger.bin",'r');
psd = fread(fid,4096,"int16");
fclose(fid);
subplot(2,2,3)
plot(psd)
grid on
title("PSD Three")

fid = fopen("psdFourinteger.bin",'r');
psd = fread(fid,4096,"int16");
fclose(fid);
subplot(2,2,4)
plot(psd)
grid on
title("PSD Four")
