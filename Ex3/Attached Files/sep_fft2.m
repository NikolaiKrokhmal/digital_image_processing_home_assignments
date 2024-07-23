%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function matFFT = sep_fft2(v1,v2)
    v1 = fft(v1);
    v2 = fft(v2);
    v2 = transpose(v2);
    matFFT =v1*v2;
end