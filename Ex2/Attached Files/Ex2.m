disp("Natan Davidov 211685300, Nikolai Krokhmal 320717184")

clc;
clear;

%% 1  RGB and Grayscale
%% 1.1
img = imread('picasso.jpg');
doubleImg = im2double(img);
minImg = min(doubleImg(:));
maxImg = max(doubleImg(:));
normalizedImg = ((doubleImg-minImg)/(maxImg-minImg));

% 1.2
figure();
imshow(normalizedImg);

% 1.3
redCh = normalizedImg(:,:,1);
greenCh = normalizedImg(:,:,2);
blueCh = normalizedImg(:,:,3);
figure();
subplot(1,3,1);
imshow(redCh);
title('Red Channel');
subplot(1,3,2);
imshow(greenCh);
title('Green Channel')
subplot(1,3,3);
imshow(blueCh);
title('Blue Channel')

% 1.4
grayImg = dip_rgb2gray(redCh, greenCh, blueCh);

% 1.5
matlab_grayImg = rgb2gray(normalizedImg);
figure();
subplot(1,2,1);
imshow(grayImg);
title('Our Grayscale');
subplot(1,2,2);
imshow(matlab_grayImg);
title('Matlab Grayscale');

similarity = ssim(grayImg, matlab_grayImg);


%% 2 Additive vs Subtractive Color space
% 2.2
black = min(1-blueCh,min(1-redCh,1-greenCh));
cyan = (1-redCh-black)./(1-black);
magenta = (1-greenCh-black)./(1-black);
yellow = (1-blueCh-black)./(1-black);

figure();
subplot(2,2,1);
imshow(black);
title('Black')
subplot(2,2,2);
imshow(cyan);
title('Cyan')
subplot(2,2,3);
imshow(magenta);
title('Magenta')
subplot(2,2,4);
imshow(yellow);
title('Yellow')

% 2.3
displayCYMK(cyan,yellow,magenta,black);


%% 3. HSV Color Space

image = imread('picasso.jpg');
hsvImage = dip_rgb2hsv(image);
hChannel = hsvImage(:,:,1);
sChannel = hsvImage(:,:,2);
vChannel = hsvImage(:,:,3);
figure;
subplot(2,2,1), imshowHSV(hChannel, sChannel, vChannel), title('Original');
subplot(2,2,2), imshow(hChannel) , title('H Channel');
subplot(2,2,3), imshow(sChannel) , title('S Channel');
subplot(2,2,4), imshow(vChannel) , title('V Channel');
matHSV = rgb2hsv(image);
figure;
subplot(1,2,1), imagesc(hsvImage), title('Our HSV Version');
subplot(1,2,2), imagesc(matHSV), title('Matlab HSV Version');
reOrderd = cat(3,image(:,:,2),image(:,:,3),image(:,:,1));
reHSV = dip_rgb2hsv(reOrderd);
reH = reHSV(:,:,1);
reS = reHSV(:,:,2);
reV = reHSV(:,:,3);
figure;
subplot(1,3,1), imshow(reH) , title('H new');
subplot(1,3,2), imshow(reS) , title('S new');
subplot(1,3,3), imshow(reV) , title('V new');


%% 4. Lab Color Space

image = double(imread("picasso.jpg")); %% change when merge
minImg = min(image(:));
maxImg = max(image(:));
normalizedImg = ((image-minImg)/(maxImg-minImg));
labImage = rgb2lab(normalizedImg);
lChannel = labImage(:,:,1);
aChannel = labImage(:,:,2);
bChannel = labImage(:,:,3);
figure();
subplot(2,2,1), imshowLab(lChannel, aChannel, bChannel), title('Original');
colormap("gray");
subplot(2,2,2), imagesc(lChannel) , title('L Channel');
subplot(2,2,3), imagesc(aChannel) , title('a Channel');
subplot(2,2,4), imagesc(bChannel) , title('b Channel');

%% 5. Compare Color Space

% RGB channel manipulation

img5 = imread('picasso.jpg');
doubleImg5 = im2double(img5);
minImg5 = min(doubleImg5(:));
maxImg5 = max(doubleImg5(:));
normalizedImg5 = ((doubleImg5-minImg5)/(maxImg5-minImg5));

redCh5 = normalizedImg5(:,:,1);
greenCh5 = normalizedImg5(:,:,2);
blueCh5 = normalizedImg5(:,:,3);
oneMat = ones(size(redCh5));
redCh5 = oneMat - redCh5;
greenCh5 = oneMat - greenCh5;
blueCh5 = oneMat - blueCh5;
zeroMat = zeros(size(redCh5));
newRGB = cat(3,redCh5,greenCh5,blueCh5);
redCh = cat(3,redCh,zeroMat,zeroMat);
greenCh = cat(3,zeroMat,greenCh,zeroMat);
blueCh = cat(3,zeroMat,zeroMat,blueCh);
redCh5 = cat(3,redCh5,zeroMat,zeroMat);
greenCh5 = cat(3,zeroMat,greenCh5,zeroMat);
blueCh5 = cat(3,zeroMat,zeroMat,blueCh5);
figure()
subplot(1,4,1), imagesc(newRGB), title('New');
subplot(1,4,2), imagesc(redCh5), title('New R');
subplot(1,4,3), imagesc(greenCh5), title('New G');
subplot(1,4,4), imagesc(blueCh5), title('New B');

%% CYMK channel manipulation

black5 = oneMat-black;
cyan5 = oneMat - cyan;
magenta5 = oneMat - magenta;
yellow5 = oneMat - yellow;
displayCYMK(cyan5,yellow5,magenta5,black5);
reconR = (oneMat - cyan5).*(oneMat - black5);
reconG =  (oneMat - magenta5).*(oneMat-black5);
reconB =  (oneMat-yellow5).*(oneMat - black5);
reconRGB = cat(3,reconR,reconG,reconB);
figure()
imagesc(reconRGB), title("new image");

%% HSV channel maniplation

newH = oneMat - hChannel;
newS = oneMat - sChannel;
newV = oneMat - vChannel;
figure();
subplot(1,3,1), imshow(newH), title('new h');
subplot(1,3,2), imshow(newS), title('new S');
subplot(1,3,3), imshow(newV), title('new V');
img123 = cat(3,newH,newS,newV);
img22 = hsv2rgb(img123);
figure()
imagesc(img22);

%% L*a*b channel manipulation

newL = 100*oneMat-lChannel;
newA = -1*aChannel;
newB = -1*bChannel;
figure()
colormap("gray");
subplot(1,3,1), imagesc(newL) , title('New L');
subplot(1,3,2), imagesc(newA) , title('New a');
subplot(1,3,3), imagesc(newB) , title('New b');
figure();
imshowLab(newL,newA,newB);

%% 6  Playing With Colors

% 6.1 

cap1 = imread("cap1.png");
cap1hsv = dip_rgb2hsv(cap1);
cap2 = imread("cap2.png");
cap2hsv = dip_rgb2hsv(cap2);
cap3 = imread("cap3.png");
cap3hsv = dip_rgb2hsv(cap3);

cap1hsv = cap1hsv(:,:,1)>0.6111 & cap1hsv(:,:,1)<0.6666 &...
        cap1hsv(:,:,3)<0.3 & cap1hsv(:,:,3)>0.1;
cap2hsv = cap2hsv(:,:,1)>0.6111 & cap2hsv(:,:,1)<0.6666 &...
        cap2hsv(:,:,3)<0.3 & cap2hsv(:,:,3)>0.1;
cap3hsv = cap3hsv(:,:,1)>0.6111 & cap3hsv(:,:,1)<0.6666 &...
        cap3hsv(:,:,3)<0.3 & cap3hsv(:,:,3)>0.1;


figure();
subplot(1,3,1);
imshow(cap1hsv);
subplot(1,3,2);
imshow(cap2hsv);
subplot(1,3,3);
imshow(cap3hsv);

cap1hsv = medfilt2(cap1hsv,[15,15]);
cap2hsv = medfilt2(cap2hsv,[15,15]);
cap3hsv = medfilt2(cap3hsv,[15,15]);

figure();
subplot(1,3,1);
imshow(cap1hsv);
subplot(1,3,2);
imshow(cap2hsv);
subplot(1,3,3);
imshow(cap3hsv);

[row1, col1] = find(cap1hsv);
x1_center = sum(col1)/length(col1);
y1_center = sum(row1)/length(row1);
cap1 = insertShape(cap1,"circle",[x1_center y1_center 30],LineWidth=5);

[row2, col2] = find(cap2hsv);
x2_center = sum(col2)/length(col2);
y2_center = sum(row2)/length(row2);
cap2 = insertShape(cap2,"circle",[x2_center y2_center 30],LineWidth=5);

[row3, col3] = find(cap3hsv);
x3_center = sum(col3)/length(col3);
y3_center = sum(row3)/length(row3);
cap3 = insertShape(cap3,"circle",[x3_center y3_center 30],LineWidth=5);

figure();
subplot(1,3,1);
imshow(cap1);
subplot(1,3,2);
imshow(cap2);
subplot(1,3,3);
imshow(cap3);