disp("Natan Davidov 211685300, Nikolai Krokhmal 320717184")

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)

%% 1 2D-Fourier Transform
%% 1.1.3 
img = imread("beatles.png");
img_gray1 = rgb2gray(img);
img_gray_double = im2double(img_gray1);
minImg = min(img_gray_double(:));
maxImg = max(img_gray_double(:));
normalized_gray_img = ((img_gray_double-minImg)/(maxImg-minImg));

figure();
imshow(normalized_gray_img);
title("Normalized grayscaled original image");

%% 1.1.4
fft = dip_fft2(normalized_gray_img);
shifted_fft = dip_fftshift(fft);
log_amp_fft = log(abs(shifted_fft));
phase = angle(shifted_fft);
figure();
subplot(1,2,1);
imagesc(log_amp_fft);
title("log|apmlitude of fft|")
colorbar();
subplot(1,2,2);
imagesc(phase);
title("phase of fft")
colorbar();

%% 1.1.5
reconstructed_img = dip_ifft2(fft);
figure();
imshow(real(reconstructed_img));
title("Reconstructed image after ifft")
colorbar();

%% 1.2 Transformation properties
%% 1.2.1 Linearity (Free Willy) 
%% (a)
load("freewilly.mat");
figure()
imshow(freewilly);
title("free willy original image")

%% (b)
fft_willy = fft2(freewilly);
figure;
imagesc(log(abs(fft_willy)));
colorbar;
title("log of amplitude of fft")

%% (c)
x = 1:640;
f_x = 10;
sinus = sin(2*pi*f_x*x/640);
one = ones(400,1);
bars = 0.5*one*sinus;
figure;
imagesc(bars);
colormap("gray");
title("bars")

%% (d)
bars_fft = fft2(bars);
bars_fft_shifted= fftshift(bars_fft);
figure;
imagesc(abs(bars_fft_shifted));
title("|fft of bars|");
colorbar();

%% (e)
binary_bars_fft = (bars_fft>1);
binary_bars_fft_filter = 1-binary_bars_fft;
figure;
imagesc(binary_bars_fft_filter);
title("binary bars fft filter");
colorbar();
freed_willy_fft = fft_willy.*binary_bars_fft_filter;
freed_willy = ifft2(freed_willy_fft);
figure;
imagesc(abs(freed_willy_fft));
title("freed willy fft");
colorbar();
figure;
imshow(freed_willy);
title("freed willy");


%% 1.2.2 Scaling, translation and seperability
%% (a)
square = zeros(128,128);
square(44:83,44:83) = 1;
square_fft = fft2(square);
figure;
imshow(square);
title("centered square");
figure;
imagesc(log(abs(fftshift(square_fft))));
title("log of amplitude of centered square");

%% (b)
square_b =zeros(128,128);
square_b(64:103,64:103) = 1;
square_b_fft = fft2(square_b);
figure;
imshow(square_b);
title("shifted square");
figure;
imagesc(log(abs(fftshift(square_b_fft))));
title("log of amplitude of shifted square");
figure;
imagesc(angle(square_fft));
title("phase of fft in section (a)");
figure;
imagesc(angle(square_b_fft));
title("phase of fft in section (b)");

%% (c)

square_c = zeros(128,128);
square_c(24:104,54:74) = 1;
square_c_fft = fft2(square_c);
figure;
subplot(1,2,1),imshow(square_c),title('80x20 ones');
subplot(1,2,2),imagesc(log(abs(fftshift(square_c_fft)))),title('fft of 80x20');

%% (d)

vec1 = zeros(128);
vec1(24:104) = 1;
vec2 = zeros(128);
vec2(54:74) = 1;
vec2_t = transpose(vec2);
myMat = vec1*vec2_t;
subplot(1,2,1),imshow(square_c),title('Original 80x20 ones');
subplot(1,2,2),imshow(myMat),title('multiplication result 80x20 ones');

%% (e)

newFFT = sep_fft2(vec1,vec2);
figure;
subplot(1,2,1),imagesc(log(abs(fftshift(square_c_fft)))),title('original fft of 80x20');
subplot(1,2,2),imagesc(log(abs(fftshift(newFFT)))),title('fft of 80x20 from 2 1d ffts');

