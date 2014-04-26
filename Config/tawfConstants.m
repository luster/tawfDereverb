% Ethan Lusterman
% Christian Sherland
%
% tawfConstants.m
%   Initializes constants for tawfDereverb.m
%

%% STFT Parameters
fs = 44100;                 % Sampling frequency (samples/sec)
frameLen   = 1024;          % Frame length in samples (samples/frame)
overlapLen = frameLen/2;  
fftLen  = frameLen;
winFunc = hamming(fftLen);

%% Algorithm Parameters
thr = 1e-15;                % Smallest value by which to scale the power spectrum

%% Artificial RIR Model
mic = [3 2 1.5];            % Microphone location
n = 12;                     % Order of reverb model
r = .93;                     % Absorption coefficient
rm  = 1*[6 6 4];            % Room dimensions
src = [3 1.8 1.5];          % Audio source location