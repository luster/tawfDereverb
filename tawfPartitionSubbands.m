function Pout = tawfPartitionSubbands(Pin,subbands)

% DC, 2, ..., , FS/2
% 1,  2, ..., , FS/2

[~,n] = size(Pin);

subbandIdxs = freq2idx(subbands.subbands, ...
    subbands.fftLen, ...
    subbands.fs);

subbandIdxs(end) = subbandIdxs(end) + 1;

numSubbands = length(subbandIdxs) - 1;

Pout = zeros(numSubbands,n);
for ii = 1:numSubbands
    Pout(ii,:) = sum(Pin(subbandIdxs(ii):subbandIdxs(ii+1)-1,:));
end

end