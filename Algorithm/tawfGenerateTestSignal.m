function wave = tawfGenerateTestSignal(freqVec, len, fs, wavtype)
%SIGNAL_GEN generates a time-domain signal of gated sine waves
%
% freqMat is a vector of all simultaneous frequencies
% len is the length of the signal in seconds
% wavtype can be 'sin' by default, or 'squ' for square and 'tri' for
% triangular waves
% fs in Hz
% gate used is a basic ADSR (attack-decay-sustain-release envelope)

if nargin < 4
    wavtype = 'sin';
end

if size(freqVec,2) ~= 1
    freqVec = freqVec';
end

lenSamples = fs*len;
n = repmat((1:lenSamples),length(freqVec),1);
f = repmat(freqVec,1,lenSamples);

argwave = 2*pi*f/fs.*n;

switch wavtype
    case 'sin'
        sig = sin(argwave);
    case 'tri'
        sig = sawtooth(argwave);
    case 'squ'
        sig = square(argwave);
end

if size(f,1) == 1
    wave = sig;
else
    wave = sum(sig);
end

A = linspace(0, 1, 0.02*len*(fs));
D = linspace(1, 0.8, 0.04*len*(fs));
S = linspace(0.8, 0.8, 0.1*len*(fs));
R = linspace(0.8, 0, 0.05*len*(fs));

ADSR = [A D S R];
if size(wave) >= size(ADSR)
    ADSR = [ADSR, zeros(1,length(wave)-length(ADSR))];
end

wave = wave .* ADSR;
wave = wave';
wave = wave/max(abs(wave));
end