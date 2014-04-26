function SRR = tawfGetSRR(x, x_hat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes heren

SRR = sum((x_hat - x)./x);

end

