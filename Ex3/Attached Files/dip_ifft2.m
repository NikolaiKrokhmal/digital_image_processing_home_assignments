%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function ifft_result = dip_ifft2(FFT)
    [M, N] = size(FFT);

    u = 0:M-1;
    v = 0:N-1;

    Wn = exp(2 * pi * 1i * (v.' * v) / N);
    Wm = exp(2 * pi * 1i * (u.' * u) / M);

    ifft_result = Wm * (FFT * Wn) / (M * N);
end