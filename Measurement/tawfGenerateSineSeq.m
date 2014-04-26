% Ethan Lusterman
% Christian Sherland
%
%   tawfGenerateSineSeq - generates a sequence of test sine wave signals
%   for measuring a certain acoustic environment's frequency response.

function [testSignals,testSignalFreqs] = tawfGenerateSineSeq(nF,nSec,sr)
numSecondsSig = nSec;               % seconds per test signal
fs = sr;                            % sample rate
numSamplesSig = fs*numSecondsSig;   % samples per test signal
numFreqs = nF;                      % number of test signals

f1 = logspace(log10(20),log10(20000), numFreqs); % 20 Hz-20 kHz
testSignalFreqs = f1;

f = repmat(f1,numSamplesSig,1);
n = repmat((1:numSamplesSig)',1,size(f,2));
testSignals = sin(2*pi/fs * f .* n);
end