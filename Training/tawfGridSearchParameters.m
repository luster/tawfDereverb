function [a, Rt, T, pars, metVec] = tawfGridSearchParameters(x, y)
%tawfGridSearchParameters Exhaustive gride search for parameters
%
%   Determine optimal parameters for Reverberation model using an
%   exhaustive grid search across all parameters given training signal and
%   training signal played through the room.
%

% Make sure constants are available
tawfConstants;


metVec = 0;
pars = 0;

% Initialize ranges to check
%a_range  = 0:0.1:0.95;
A = 0.75;
%a_range = 0.75;
Rt_range = 1:0.1:2.0;
T_range  = 0.02:0.01:.1;

% Setup meshgrid to loop over
% [xx,yy,zz] = meshgrid(a_range, T_range, Rt_range);
% pars = [xx(:),yy(:),zz(:)];
% aa = pars(:,1);
% tt = pars(:,2);
% rtrt = pars(:,3);
%
% % Keep track of progress and metrics
%metVec = zeros(1,size(pars,1));
% len = size(pars,1);
%h = waitbar(0,'');

% post-pad with zeros to make buffer nice
y = [y; zeros(frameLen-overlapLen-mod(length(y),frameLen-overlapLen),1)];
x = [x; zeros(length(y)-length(x),1)];

% Calculate STFT outside of algorithm to avoid redundant calculations
Y = tawfSTFT(y, frameLen, overlapLen, winFunc);

% for ii = 1:len
%     metVec(ii) = tawfGetMetricForParams(aa(ii), tt(ii), rtrt(ii), x, y, Y);
%     if ~mod(ii,10)
%         waitbar(ii/len,h,sprintf('%d',ii/len));
%     end
% end

bestMet = -1e10;

for rt1 = 1:length(Rt_range)
    for rt2 = 1:length(Rt_range)
        for T_id = 1:length(T_range)
            rt = [ones(1, 13)*Rt_range(rt1), ones(1,12)*Rt_range(rt2)]';
            met = tawfGetMetricForParams(A, T_range(T_id), rt, x, y, Y);
            
            if (met > bestMet)
                bestMet = met;
                a = A;
                T = T_range(T_id);
                Rt = rt;
            end
        end
    end
end



% for rt1 = 1:length(Rt_range)
%     for rt2 = 1:length(Rt_range)
%         for rt3 = 1:length(Rt_range)
%             for rt4 = 1:length(Rt_range)
%                 for rt5 = 1:length(Rt_range)
%                     for rt6 = 1:length(Rt_range)
%                         for rt7 = 1:length(Rt_range)
%                             for rt8 = 1:length(Rt_range)
%                                 for rt9 = 1:length(Rt_range)
%                                     for rt10 = 1:length(Rt_range)
%                                         for rt11 = 1:length(Rt_range)
%                                             for rt12 = 1:length(Rt_range)
%                                                 for rt13 = 1:length(Rt_range)
%                                                     for rt14 = 1:length(Rt_range)
%                                                         for rt15 = 1:length(Rt_range)
%                                                             for rt16 = 1:length(Rt_range)
%                                                                 disp('merp')
%                                                                 waitbar(rt16/length(Rt_range), h, sprintf('%d',(rt16/length(Rt_range))));
%                                                                 for rt17 = 1:length(Rt_range)
%                                                                     for rt18 = 1:length(Rt_range)
%                                                                         for rt19 = 1:length(Rt_range)
%                                                                             for rt20 = 1:length(Rt_range)
%                                                                                 for rt21 = 1:length(Rt_range)
%                                                                                     for rt22 = 1:length(Rt_range)
%                                                                                         for rt23 = 1:length(Rt_range)
%                                                                                             for rt24 = 1:length(Rt_range)
%                                                                                                 for rt25 = 1:length(Rt_range)
%                                                                                                     for T_id = 1:length(T_range)
%                                                                                                         rt = [Rt_range(rt1), Rt_range(rt2), Rt_range(rt3), ...
%                                                                                                             Rt_range(rt4), Rt_range(rt5), Rt_range(rt6), ...
%                                                                                                             Rt_range(rt7), Rt_range(rt8), Rt_range(rt9), ...
%                                                                                                             Rt_range(rt10), Rt_range(rt11), Rt_range(rt12), ...
%                                                                                                             Rt_range(rt13), Rt_range(rt14), Rt_range(rt15), ...
%                                                                                                             Rt_range(rt16), Rt_range(rt17), Rt_range(rt18), ...
%                                                                                                             Rt_range(rt19), Rt_range(rt20), Rt_range(rt21), ...
%                                                                                                             Rt_range(rt22), Rt_range(rt23), Rt_range(rt24), ...
%                                                                                                             Rt_range(rt25)]';
%
%                                                                                                         met = tawfGetMetricForParams(A, T_range(T_id), rt, x, y, Y);
%
%                                                                                                         if (met > bestMet)
%                                                                                                             bestMet = met;
%                                                                                                             a = A;
%                                                                                                             T = T_range(T_id);
%                                                                                                             Rt = rt;
%                                                                                                         end
%                                                                                                     end
%                                                                                                 end
%                                                                                             end
%                                                                                         end
%                                                                                     end
%                                                                                 end
%                                                                             end
%                                                                         end
%                                                                     end
%                                                                 end
%                                                             end
%                                                         end
%                                                     end
%                                                 end
%                                             end
%                                         end
%                                     end
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end

%close(h);

% Figure out the best value
%[~,idx] = max(metVec);
% a  = pars(idx,1);
% T  = pars(idx,2);
% Rt = pars(idx,3);

end