% Ethan Lusterman
% Christian Sherland
%
%   tawfPlayRecordTrainSignal - plays training signal and records it
function out = tawfPlayRecordTrainSignal(trainSignal, fs, bitDepth)

r = audiorecorder(fs,bitDepth,1);
p = audioplayer(trainSignal,fs); %#ok<*TNMLP>
play(p);
recordblocking(r,length(trainSignal)/fs);
out = getaudiodata(r);

end