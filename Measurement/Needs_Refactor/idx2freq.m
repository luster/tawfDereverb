function out = idx2freq(idx,fftlen,fs)

out = (idx-1)*fs/fftlen;

end