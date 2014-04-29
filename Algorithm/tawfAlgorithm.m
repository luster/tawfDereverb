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

% Subband Partition
subbands_ = tawfSubbands(fs);
subbands.subbands = subbands_;
subbands.fftLen = fftLen;
subbands.fs = fs;
Pyy_ = tawfPartitionSubbands(Pyy,subbands);

Prr = tawfEstimateReverbPower(exp(-2*delta*T), Pyy_, N);

% Calculate gain coefficients and threshold (Eqn 7.)
G = sqrt((Pyy_ - Prr)./Pyy_);
G(G < thr)  = thr;
G(isnan(G)) = thr;

% Gain interpolation
subbandIdxs = freq2idx(subbands_,fftLen,fs);
% G_ = zeros(size(Y));
G_ = [];

repmatNumbers = subbandIdxs - [0;subbandIdxs(1:end-1)];
repmatNumbers(2) = repmatNumbers(2) + repmatNumbers(1);
repmatNumbers(1) = [];
for ii=1:length(subbandIdxs)-1
    G_ = [G_; repmat(G(ii,:),repmatNumbers(ii),1)];
end

for i = 1:size(G_,1)
    G_(i,:) = smooth(G_(i,:),3)';
end

% Apply gain to STFT to scale out reverb power
%W = [G_;flipud(G(2:end-1,:
W = (G_ .* Y(1:fftLen/2+1,:));
W = [W; conj(flipud(W(2:fftLen/2,:)))];

% Reconstruct Dereveberated Signal
x_hat = tawfInverseSTFT(W, winFunc); % IFFT & Overlap Add

end