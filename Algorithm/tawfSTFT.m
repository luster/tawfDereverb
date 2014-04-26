function [Y] = tawfSTFT(y, frameLen, overlapLen, window)
%UNTITLED6 Summary of this function goes here
%   Buffer data, apply window and compute the fft

yb = buffer(y,frameLen,overlapLen,'nodelay');
winFunc = repmat(window,1,size(yb,2));
yb = yb .* winFunc;
Y = fft(yb);

end