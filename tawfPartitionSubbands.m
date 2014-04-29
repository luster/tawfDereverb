function Pout = tawfPartitionSubbands(Pin,subbands)

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