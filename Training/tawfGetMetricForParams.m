function [metric] = tawfGetMetricForParams(a, T, Rt, x, y, Y)
%tawfGridSearchParameters Exhaustive gride search for parameters
%
%   Determine optimal parameters for Reverberation model using an
%   exhaustive gride search across all parameters.

[x_hat,~] = tawfAlgorithm(a, Rt, T, Y);
metric    = tawfGetMetric(x,y,x_hat);

end