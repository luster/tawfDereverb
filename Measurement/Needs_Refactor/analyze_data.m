
load_input_data;
s0 = struct('out',in);
s1 = load('anechoic_sinewaves2');
s2 = load('anechoic_sinewaves3');
s3 = load('anechoic_sinewaves4');

%%
inResponse = zeros(1,length(f1));
response = zeros(3,length(f1));
for ii = 0:3
    % grab one set of measurements
    str = sprintf('s%d',ii);
    x = eval(str);
    out = x.out;
    
    % get fft
    fftOut = fft(out);
    
    % take only first half since symmetric
    fftOut = fftOut(1:numSamplesSig/2,:);
    magfftOut = abs(fftOut);
    
    % zero out fft coefficients that correspond to frequencies below 20Hz
    idx = freq2idx(20,numSamplesSig,fs) - 1;
    magfftOut(1:idx,:) = 0;
    
    % find max value (within ± 1 of actual frequency being played)
    [vals,idxs] = max(magfftOut,[],1);
    maxFreqs = idx2freq(idxs,numSamplesSig,fs);
    
    % append coefficients to response
    if and((sum(idxs==trueIdxs) + ... 
            sum(idxs-1==trueIdxs) + ...
            sum(idxs+1==trueIdxs) == numFreqs),(ii ~= 0))
        disp('here')
        response(ii,:) = vals;
    else
        disp('there')
        inResponse = vals;
    end
    
end

% take average response over iterations
avgIter = mean(response);

% normalize from input response to find magnitude gain
avgIter = avgIter ./ inResponse;

% plot frequency response of room
semilogx(f1,avgIter)