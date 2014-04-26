function metric = tawfGetMetric(x,y,x_hat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% [0.01*tawfGetSIR(x,y,x_hat), .001/tawfGetMSE(x,x_hat)]
% metric = tawfGetSRR(x,x_hat);

% metric = sqrt(0.1*tawfGetSIR(x,y,x_hat)) + .001/tawfGetMSE(x,x_hat);
metric = tawfGetSIR(x,y,x_hat);
% metric = tawfGetMSE(x,x_hat);

end