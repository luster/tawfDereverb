% Ethan Lusterman
% Christian Sherland
%
%   tawfPlayRecordSave - plays test input data and records it, saving the
%   output data to a MATLAB .mat file

function tawfPlayRecordSave(nFreqs,nSecFreq,fs,bitDepth,saveFilename)

[in,f] = tawfGenerateSineSeq(nFreqs,nSecFreq,fs); % generate test waves
out = zeros(size(in)); % initialize output
ofLen = size(in,2);

for ii = 1:size(in,2)
    fprintf('Processing %d of %d\n',ii,ofLen);
    p = audioplayer(in(:,ii),fs); %#ok<*TNMLP>
    play(p);
    r = audiorecorder(fs,bitDepth,1);
    recordblocking(r,nSecFreq);
    out(:,ii) = getaudiodata(r);
end

save(saveFilename, 'out','f');
end