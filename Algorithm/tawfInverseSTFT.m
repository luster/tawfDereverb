function [x_hat] = tawfInverseSTFT(W, winFunc)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

xb_hat = ifft(W);
invWinFunct = repmat(1./winFunc,1,size(xb_hat,2));
xb_hat = xb_hat .* invWinFunct;

m = size(xb_hat,1);
n = size(xb_hat,2);

%% Overlap-add helpers - assumes 50% overlap

% TODO: odd number m
upperMat = xb_hat(1:m/2,:);
lowerMat = xb_hat(m/2+1:end,:);

leftCol = [upperMat(:); zeros(m/2,1)];
leftCol(1:m/2) = 2 * leftCol(1:m/2);
rightCol = [zeros(m/2,1); lowerMat(:)];
rightCol(end-m/2:end) = 2 * rightCol(end-m/2:end);

x_hat = mean([leftCol,rightCol],2);

end

