function [a, Rt, T, pars, metVec] = tawfGridSearchParameters(x, y)
%tawfGridSearchParameters Exhaustive gride search for parameters
%
%   Determine optimal parameters for Reverberation model using an
%   exhaustive grid search across all parameters given training signal and
%   training signal played through the room.
%

% Make sure constants are available
tawfConstants;

% Initialize ranges to check
a_range  = 0:0.1:0.95;
Rt_range = 0.1:0.2:2.5;
T_range  = 0.02:0.01:.1;

% Setup meshgrid to loop over
[xx,yy,zz] = meshgrid(a_range, T_range, Rt_range);
pars = [xx(:),yy(:),zz(:)];
aa = pars(:,1);
tt = pars(:,2);
rtrt = pars(:,3);

% Keep track of progress and metrics
metVec = zeros(1,size(pars,1));
len = size(pars,1);
h = waitbar(0,'');

% post-pad with zeros to make buffer nice
y = [y; zeros(frameLen-overlapLen-mod(length(y),frameLen-overlapLen),1)];
x = [x; zeros(length(y)-length(x),1)];

% Calculate STFT outside of algorithm to avoid redundant calculations
Y = tawfSTFT(y, frameLen, overlapLen, winFunc);

for ii = 1:len
    metVec(ii) = tawfGetMetricForParams(aa(ii), tt(ii), rtrt(ii), x, y, Y);
    if ~mod(ii,10)
        waitbar(ii/len,h,sprintf('%d',ii/len));
    end
end
close(h);

plot(metVec);

% Figure out the best value
[~,idx] = max(metVec);
a  = pars(idx,1);
T  = pars(idx,2);
Rt = pars(idx,3);

end