function [x_hat,G] = tawfAlgorithm(a, Rt, T, Y)

tawfConstants;

% Reverb model parameters
N = round(T*fs/frameLen);
if N==0
    N=1;
end
delta = 3 * log(10) / Rt;

% Dereveberation algorithm
Pyy = tawfEstimatePSD(Y, a);
Prr = tawfEstimateReverbPower(1*exp(-2*delta*T), Pyy, N);

% Calculate gain coefficients and threshold (Eqn 7.)
G = sqrt((Pyy - Prr)./Pyy);
G(G < thr)  = thr;
G(isnan(G)) = thr;

% for i = 1:frameLen
%     G(i,:) = smooth(G(i,:))';
% end

% Apply gain to STFT to scale out reverb power
W = (G .* Y);

% Reconstruct Dereveberated Signal
x_hat = tawfInverseSTFT(W, winFunc); % IFFT & Overlap Add

end