function [reverbPower] = tawfEstimateReverbPower(reverbModel, signalPSD, N)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

reverbPower = zeros(size(signalPSD));
reverbPower(:,N+1:end) = repmat(reverbModel, 1,size(signalPSD,2)-N)  .* signalPSD(:,1:end-N);

end