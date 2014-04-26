clear all
close all
clc
addpath(genpath('..'));
tawfConstants;

%% Base case: sine waves

a = 0.5;
Rt = 1.5;
T = 0.12;

h = tawfGenerateRIR(fs, mic, n, r, rm, src);
x = tawfGenerateTestSignal(440*[1,6/5,3/2], 1, fs, 'tri');
% x2 = tawfGenerateTestSignal(880*[1,5/4,3/2], 1, fs, 'tri');
x = x * 0.8 / max(abs(x));
x = x(1:length(x)/4);
% x2 = x2 * 0.8 / max(abs(x2));
% x = [x; x2];
y = conv(h, x);

% post-pad with zeros to make buffer nice
y = [y; zeros(frameLen-overlapLen-mod(length(y),frameLen-overlapLen),1)];
x = [x; zeros(length(y)-length(x),1)];
tic

% Window and FFT
Y = tawfSTFT(y, frameLen, overlapLen, winFunc);
% Pyy = tawfEstimatePSD(Y, a);


% Get dat estimated signal doe
[~,G] = tawfAlgorithm(a, Rt, T, Y);

for i = 1:frameLen
    G(i,:) = smooth(G(i,:))';
end

% Apply gain to STFT to scale out reverb power
W = G .* Y;

% Reconstruct Dereveberated Signal
x_hat = tawfInverseSTFT(W, winFunc); % IFFT & Overlap Add
toc
% Check out what the algorithm actually did
figure(1);
% subplot(2,2,1),plot(y), ylim([-1 1]),           title('Reverberant signal y(t)')
% subplot(2,2,2),plot(x_hat,'r'), ylim([-1 1]),   title('Estimated signal x_hat(t)')
% subplot(2,2,3),hist(G(:)),                      title('Histogram of time-frequency gain coefficients')
% subplot(2,2,4),plot(abs(y-x_hat)),              title('|y(t)-x(t)|')

n = linspace(0,length(x)/fs,length(x));

subplot(311)
plot(n,x, 'b')
ylim([-1 1])
title('Direct Signal x(t)','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

subplot(312)
plot(n,y, 'g')
ylim([-1 1])
title('Reverberant Signal y(t)','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

subplot(313)
plot(n,x_hat, 'r')
ylim([-1 1])
title('Estimated Signal $\hat x(t)$','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

% Listen to the original and the result
o = audioplayer(x,fs);
re = audioplayer(y,fs);
p = audioplayer(x_hat/max(abs(x_hat)),fs);
fprintf('Playing original...\n'); playblocking(o);
fprintf('Playing echo...\n'); playblocking(re);
fprintf('Playing estimated signal...\n'); playblocking(p);

figure(2);
FF = linspace(0.1,1000,100);
subplot(3,1,1), spectrogram(x,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,2), spectrogram(y,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,3), spectrogram(x_hat,winFunc,overlapLen,FF,fs,'yaxis');

%% More complex case: pluck

a = 0.8;
Rt = 1.3;
T = 0.09;

x = audioread('pluck.wav');
% y = conv(h,x);
y = audioread('pluck_out.wav');

% post-pad with zeros to make buffer nice
y = [y; zeros(frameLen-overlapLen-mod(length(y),frameLen-overlapLen),1)];
x = [x; zeros(length(y)-length(x),1)];

% Window and FFT
Y = tawfSTFT(y, frameLen, overlapLen, winFunc);
Pyy = tawfEstimatePSD(Y, a);

% Get dat estimated signal doe
[~,G] = tawfAlgorithm(a, Rt, T, Y);

for i = 1:frameLen
    G(i,:) = smooth(G(i,:))';
end

% Apply gain to STFT to scale out reverb power
W = G .* Y;

% Reconstruct Dereveberated Signal
x_hat = tawfInverseSTFT(W, winFunc); % IFFT & Overlap Add

% Check out what the algorithm actually did
figure(3);
% subplot(2,2,1),plot(y), ylim([-1 1]),           title('Reverberant signal y(t)')
% subplot(2,2,2),plot(x_hat,'r'), ylim([-1 1]),   title('Estimated signal x_hat(t)')
% subplot(2,2,3),hist(G(:)),                      title('Histogram of time-frequency gain coefficients')
% subplot(2,2,4),plot(abs(y-x_hat)),              title('|y(t)-x(t)|')

n = linspace(0,length(x)/fs,length(x));

subplot(311)
plot(n,x, 'b')
ylim([-1 1]), xlim([0 1])
title('Direct Signal x(t)','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

subplot(312)
plot(n,y, 'g')
ylim([-1 1]), xlim([0 1])
title('Reverberant Signal y(t)','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

subplot(313)
plot(n,x_hat, 'r')
ylim([-1 1]), xlim([0 1])
title('Estimated Signal $\hat x(t)$','interpreter','latex')
xlabel('time (sec)','interpreter','latex')

% Listen to the original and the result
o = audioplayer(x,fs);
r = audioplayer(y,fs);
p = audioplayer(x_hat/max(abs(x_hat)),fs);
fprintf('Playing original...\n'); playblocking(o);
fprintf('Playing echo...\n'); playblocking(r);
fprintf('Playing estimated signal...\n'); playblocking(p);

figure(4);
FF = linspace(20,1000,100);
subplot(3,1,1), spectrogram(x,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,2), spectrogram(y,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,3), spectrogram(x_hat,winFunc,overlapLen,FF,fs,'yaxis');

%% Learning

main;