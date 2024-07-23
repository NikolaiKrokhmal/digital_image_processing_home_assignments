%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function fft_result = dip_fft2(I)
    [M, N] = size(I);

    u = 0:M-1;
    v = 0:N-1;

    Wn = exp(-2 * pi * 1i * (v.' * v) / N);
    Wm = exp(-2 * pi * 1i * (u.' * u) / M);

    fft_result = Wm * (I * Wn);
end



