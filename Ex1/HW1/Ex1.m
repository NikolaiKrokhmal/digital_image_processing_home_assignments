disp("Natan Davidov 211685300, Nikolai Krokhmal 320717184")

%%

% 1.1.1 Reading the Image
grayScaleImg = double(rgb2gray(imread(fullfile('Images','picasso.jpg'))));
figure;
imagesc(grayScaleImg);
colormap("gray");
colorbar;
title("Picaso Gray Scale");

%%

% 1.1.2
normalized = dip_GN_imread('picasso.jpg');

%%

% 1.2  Histogram Construction
myHist = dip_histogram('Images\picasso.jpg',256); % here we build our own histogram
nVec = 1:1:256;
figure;
subplot(1,2,1);
plot(nVec,myHist);
title('Our Histogram');
subplot(1,2,2);
image = imread(fullfile('Images','picasso.jpg')); 
imhist(rgb2gray(image)); % we take the original histogram for comparisson
title('Original Histogram')

%%

%1.3 Brightness
modifiedImage = adjust_brightness(normalized,'mul',3);
figure;
subplot(1,2,1);
colormap("gray");
imagesc(modifiedImage)
title('Adjusted Brightness');
subplot(1,2,2);
colormap("gray");
imagesc(normalized);
title('Original Normalized Image');

%%

% 1.4 Contrast
adjCon1 = adjust_contrast(normalized,0.45,0.9);
figure;
subplot(2,2,1);
colormap("gray");
imshow(adjCon1);
title("Adjusted Contrust to Range [0.45,0.9]");
subplot(2,2,3)
imhist(adjCon1);
title('[0.45,0.9] Histogram')
adjCon2 = adjust_contrast(normalized,0.45,0.5);
subplot(2,2,2);
colormap("gray");
imshow(adjCon2);
title("Adjusted Contrust to Range [0.45,0.5]");
subplot(2,2,4);
imhist(adjCon2);
title('[0.45,0.5] Histogram')

%%

% 1.5 Quantization
% here we want to quantize the image
[rows,cols] = size(grayScaleImg);
quant4 = zeros(size(grayScaleImg)); % create matrices for the new images
quant1 = zeros(size(grayScaleImg));
for row = 1:rows % we the amount of new bins is 2^4 and 2 respectively.
    % we devide the histogram into those two bins pixel by pixel
    for col = 1:cols
        quant4(row,col) = floor(grayScaleImg(row,col)/16)*16;
        quant1(row,col) = floor(grayScaleImg(row,col)/128)*128;
    end
end
figure;
subplot(1,2,1);
colormap("gray");
imagesc(quant4);
title("Picasso With 4 bit Quantization");
subplot(1,2,2);
colormap("gray");
imagesc(quant1);
title("Picasso With 1 bit Quantization");

%%

% 1.6 Histogram Equalization
grayDog = dip_GN_imread("dog.jpg");
equalizedDog = histeq(grayDog);
figure;
subplot(1,2,1);
colormap('gray');
imagesc(equalizedDog);
subplot(1,2,2);
imhist(equalizedDog);

%% 
%
% 2.1 Spatial Filters and Noise
dog_gn = dip_GN_imread('dog.jpg');

%% 

% 2.2.1
dog = dip_GN_imread('dog.jpg');
figure
colormap('gray')
imagesc(dog)
mean_filter_dog = mean_filter(dog,5);

%%

% 2.2.2
k = 200;
median_filter_dog = medfilt2(dog,[k,k]);
figure
colormap('gray')
imagesc(median_filter_dog)

%%

% 2.2.3
mean3 = mean_filter(dog, 3);
mean9 = mean_filter(dog, 9);
med3 = medfilt2(dog,[3,3]);
med9 = medfilt2(dog,[9,9]);
figure;
subplot(1, 2, 1);
colormap('gray');
imagesc(mean3);
title('mean k=3');
subplot(1, 2, 2);
colormap('gray');
imagesc(med3);
title('median k=3');

figure;
subplot(1, 2, 1);
colormap('gray');
imagesc(mean9);
title('mean k=9');
subplot(1, 2, 2);
colormap('gray');
imagesc(med9);
title('median k=9');

%% 

% 2.3.2
gauss1 = dip_gaussian_filter(dog, 3, 0.2);
gauss2 = dip_gaussian_filter(dog, 3, 1.7);
gauss3 = dip_gaussian_filter(dog, 9, 0.2);
figure;
subplot(1,3,1);
colormap('gray');
imagesc(gauss1);
title('(k, sigma) = (3, 0.2)');
subplot(1,3,2);
imagesc(gauss2);
title('(k, sigma) = (3, 1.7)');
subplot(1,3,3);
imagesc(gauss3);
title('(k, sigma) = (9, 0.2)');

%%

% 2.3.3
sub = dog - gauss1;
imshow(sub, [])

%%

% 2.4 Noise Filtering
noised1 = imnoise(dog, "salt & pepper");
noised2 = imnoise(dog, "gaussian");

noised1mean3 = mean_filter(noised1, 3);
noised1mean9 = mean_filter(noised1, 9);
noised1med3 = medfilt2(noised1,[3,3]);
noised1med9 = medfilt2(noised1,[9,9]);
noised1gauss3 = dip_gaussian_filter(noised1, 3 ,1);
noised1gauss9 = dip_gaussian_filter(noised1,9 ,1);

noised2mean3 = mean_filter(noised2, 3);
noised2mean9 = mean_filter(noised2, 9);
noised2med3 = medfilt2(noised2,[3,3]);
noised2med9 = medfilt2(noised2,[9,9]);
noised2gauss3 = dip_gaussian_filter(noised2, 3 ,1);
noised2gauss9 = dip_gaussian_filter(noised2,9 ,1);

% figure;
% colormap('gray');
% subplot(2,6,1);
% imagesc(noised1mean3);
% title("noised s&p mean 3");
% subplot(2,6,2);
% imagesc(noised1mean9);
% title("noised s&p mean 9");
% subplot(2,6,3);
% imagesc(noised1med3);
% title("noised s&p med 3");
% subplot(2,6,4);
% imagesc(noised1med9);
% title("noised s&p med 9");
% subplot(2,6,5);
% imagesc(noised1gauss3);
% title("noised s&p gauss 3");
% subplot(2,6,6);
% imagesc(noised1gauss9);
% title("noised s&p gauss 9");
% 
% 
% colormap('gray');
% subplot(2,6,7);
% imagesc(noised2mean3);
% title("noised gauss mean 3");
% subplot(2,6,8);
% imagesc(noised2mean9);
% title("noised gauss mean 9");
% subplot(2,6,9);
% imagesc(noised2med3);
% title("noised gauss med 3");
% subplot(2,6,10);
% imagesc(noised2med9);
% title("noised gauss med 9");
% subplot(2,6,11);
% imagesc(noised2gauss3);
% title("noised gauss gauss 3");
% subplot(2,6,12);
% imagesc(noised2gauss9);
% title("noised gauss gauss 9");

figure;
subplot(1,2,1);
colormap("gray");
imagesc(noised1med3);
title("noise: s&p, best filter: median 3");
subplot(1,2,2);
imagesc(noised2gauss3);
title("noise:gauss, best filter: gauss 3");



