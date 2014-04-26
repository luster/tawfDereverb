function [reverbPower] = tawfEstimateReverbPower(reverbModel, signalPSD, N)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

reverbPower = zeros(size(signalPSD));
reverbPower(:,N+1:end) = reverbModel * signalPSD(:,1:end-N);

end