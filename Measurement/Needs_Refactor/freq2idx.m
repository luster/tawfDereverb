function out = freq2idx(f,fftlen,fs)

out = round(f/fs * fftlen + 1);

end