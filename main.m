% Ethan Lusterman
% Christian Sherland
%
% Dereverberation Algorithm with Paramater Estimation

addpath(genpath('..'));
tawfConstants;

[x,fs] = audioread('dryspeech.mp3');  x = x(:,1);

% For artificial signal
h = tawfGenerateRIR(fs, mic, n, r, rm, src);
% x = tawfGenerateTestSignal(440*[1,6/5,3/2], 1, fs, 'sin');
x = x * 0.5 / max(abs(x));
y = conv(h, x);

% Real signal
% x = audioread('white_in.wav'); x = x(:,1);
% y = audioread('white_out.wav'); y = y(:,1);
% Real signal
% y = conv(h,x);
% y = audioread('REVERB.wav'); y = y(:,1);
% fs = 48000;

% [x,fs] = audioread('gtr.wav');
% [y,fs] = audioread('gtr_out.wav');
% x = x(1:length(x)/4);
% y = y(1:length(y)/4);

% Get the parameters
% rn = 44100*3:44100*5;
[a, Rt, T, pars, metVec] = tawfGridSearchParameters(x,y);

% Real signal
% x = audioread('gtr_in.wav'); x = x(:,1);
% y = conv(h,x);
% y = audioread('gtr_out.wav'); y = y(:,1);

% post-pad with zeros to make buffer nice
y = [y; zeros(frameLen-overlapLen-mod(length(y),frameLen-overlapLen),1)];
x = [x; zeros(length(y)-length(x),1)];

% Window and FFT
% tic;
Y = tawfSTFT(y, frameLen, overlapLen, winFunc);
%Pyy = tawfEstimatePSD(Y, a);
%%

% Get dat estimated signal doe
[x_hat,G] = tawfAlgorithm(a, Rt, T, Y);

% for i = 1:frameLen
%     G(i,:) = smooth(G(i,:))';
% end
% 
% % Apply gain to STFT to scale out reverb power
% W = G .* Y;
% 
% % Reconstruct Dereveberated Signal
% x_hat = tawfInverseSTFT(W, winFunc); % IFFT & Overlap Add
toc;
% Check out what the algorithm actually did
figure(5);
subplot(2,2,1),plot(x), ylim([-1 1]),           title('Reverberant signal y(t)')
subplot(2,2,2),plot(x_hat,'r'), ylim([-1 1]),   title('Estimated signal x_hat(t)')
subplot(2,2,3),hist(G(:)),                      title('Histogram of time-frequency gain coefficients')
subplot(2,2,4),plot(abs(y-x_hat)),              title('|y(t)-x(t)|')

% Listen to the original and the result
o = audioplayer(x,fs);
r = audioplayer(y,fs);
p = audioplayer(x_hat/max(abs(x_hat)),fs);
% playblocking(o,[1,fs*5]);
playblocking(r);
playblocking(p);

% Spectrogram plots
figure();
FF = linspace(0.1,1000,100);
subplot(3,1,1), spectrogram(x,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,2), spectrogram(y,winFunc,overlapLen,FF,fs,'yaxis');
subplot(3,1,3), spectrogram(x_hat,winFunc,overlapLen,FF,fs,'yaxis');