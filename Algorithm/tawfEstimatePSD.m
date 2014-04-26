function [estPSD] = tawfEstimatePSD(signalSTFT, weight)
%tawfEstimatePSD Estimation of the PSD of a supplied signalSTFT
%   Estimates the PSD of the input STFT using Eqn (8) from Shi & Ma.
%   Uses a running average the weights previous frame powers using the
%   scaling factor specified by 'weight'

estPSD = zeros(size(signalSTFT));
%scf = (1/2/pi/size(signalSTFT,1));
estPSD(:,1) = abs(signalSTFT(:,1)).^2;
for ii = 2:size(estPSD,2)
    estPSD(:,ii) = weight * estPSD(:,ii-1) + (1-weight) * abs(signalSTFT(:,ii)).^2;
end

end