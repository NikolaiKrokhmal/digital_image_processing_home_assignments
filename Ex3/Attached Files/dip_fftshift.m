%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function fftshift = dip_fftshift(FFT)
    [M, N] = size(FFT);
    fftshift = FFT;
    fftshift(1:floor(M/2),1:floor(N/2)) = FFT(floor(M/2)+1:M,floor(N/2)+1:N); %switch block 3 to 1
    fftshift(floor(M/2)+1:M,floor(N/2)+1:N) = FFT(1:floor(M/2),1:floor(N/2)); %switch block 1 to 3
    fftshift(floor(M/2)+1:M,1:floor(N/2)) = FFT(1:floor(M/2),floor(N/2)+1:N); %switch block 2 to 4
    fftshift(1:floor(M/2),floor(N/2)+1:N) = FFT(floor(M/2)+1:M,1:floor(N/2)); %switch block 4 to 2
end
