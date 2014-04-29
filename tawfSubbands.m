function subbands = tawfSubbands(fs)

% subband frequency values in Hz. fs/2>15000
subbands = [
    0
    100
    200
    300
    400
    510
    630
    770
    920
    1080
    1270
    1480
    1720
    2000
    2320
    2700
    3150
    3700
    4400
    5300
    6400
    7700
    9500
    12000
    15500
    fs/2
    ];

subbands(subbands>=fs/2)=[];
subbands(end+1) = fs/2;

end