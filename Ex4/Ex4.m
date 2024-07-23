disp("Natan Davidov 211685300, Nikolai Krokhmal 320717184")
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)

%% Edge Detection

%% 1.1.1 Reading the Image
img = imread('cameraman.tif');

img_double = im2double(img);
minImg = min(img_double(:));
maxImg = max(img_double(:));
norm_img = ((img_double-minImg)/(maxImg-minImg));
imshow(norm_img);

%% 1.2 Prewitt Edge Detector
edge_t1 = dip_prewitt_edge(norm_img, 0.1);
figure;
imshow(edge_t1);
title('Prewitt Edge Detector with thresh=0.1')
edge_t2 = dip_prewitt_edge(norm_img, 0.2);
figure;
imshow(edge_t2);
title('Prewitt Edge Detector with thresh=0.2')

%% 1.3 Canny Edge Detector
%1
edge1 = edge(norm_img,"canny");
edge2 = edge(norm_img,"canny",[0.2,0.8]);
figure;
imshow(edge1);
title("Canny with default threshold");
figure;
imshow(edge2);
title("Canny with thresholds: 0.8,0.2");

%2
[edge3, threshold] = edge(norm_img,"canny");
disp(threshold)

edge4 = edge(norm_img,"canny",[0.1,0.2]);
imshow(edge4);
title("Canny with thresholds: 0.1,0.2")

%% 2 Hough Transform

% 2.1 - Hough Line Transform

myImage21 = imread("floor.jpg"); % reading image, converting to greyscale and normalizing
greyImg21 = double(rgb2gray(myImage21));
minImg21 = min(greyImg21(:));
maxImg21 = max(greyImg21(:));
norm_img21 = ((greyImg21-minImg21)/(maxImg21-minImg21));
BW = edge(norm_img21);
figure();
imshow(BW); 
houghLine1 = dip_hough_lines(BW,1,1); % get hough matrices
figure()
subplot(1,2,1); imagesc(houghLine1);colormap('turbo'); title('Hough Matrix with resolution R=1 and Theta =1')
houghLine2 = dip_hough_lines(BW,5,4);
subplot(1,2,2); imagesc(houghLine2);colormap('turbo'); title('Hough Matrix with resolution R=5 and Theta =4');
% here we calculate and draw the lines
peaks1 = houghpeaks(houghLine1,4);
figure();
imshow(norm_img21);
title("found lines for r=1 and theta = 1")
hold("on");
%here we calculate the actual r and theta from the indices
[N,M] = size(BW);
rMax = sqrt((N^2)+(M^2));
R_vec = -round(rMax) : 1 : round(rMax);
tta_vec = -90:1:90;
%here we calculate 2 points and draw a line
for i = 1:length(peaks1)
    r = R_vec(peaks1(i,1));
    tta = tta_vec(peaks1(i,2));
    x1 = 0;
    x2 = 600;
    y1 = (r-x1.*cosd(tta))/sind(tta);
    y2 = (r-x2.*cosd(tta))/sind(tta);
    line([x1,x2],[y1,y2],'LineWidth',3);
end
hold("off");

%same here again
peaks2 = houghpeaks(houghLine2,4, "Threshold", 0.3*max(houghLine2(:)));
figure();
imshow(norm_img21);
title("found lines for r=5 and theta = 4")
hold("on");
R_vec2 = -round(rMax) : 5 : round(rMax);
tta_vec2 = -90:4:90;
for i = 1:length(peaks2)
    r = R_vec2(peaks2(i,1));
    tta = tta_vec2(peaks2(i,2));
    a1 = 0;
    a2 = 600;
    b1 = (r-a1.*cosd(tta))/sind(tta);
    b2 = (r-a2.*cosd(tta))/sind(tta);
    line([a1,a2],[b1,b2],'LineWidth',3);
end

%% 2.2 

myImage22 = imread("coffee.jpg"); % reading image, converting to greyscale and normalizing
greyImg22 = double(rgb2gray(myImage22));
minImg22 = min(greyImg22(:));
maxImg22 = max(greyImg22(:));
norm_img22 = ((greyImg22-minImg22)/(maxImg22-minImg22));
BW22 = edge(norm_img22);
figure();
imshow(BW22);
%%
tic;houghCircles_1_1 = dip_hough_circles(BW22,1,1);toc;
houghCircles_10_4 = dip_hough_circles(BW22,4,10);

%%
peaks_1_1 = dip_houghpeaks3d(houghCircles_1_1);
figure();
imshow(norm_img22);
hold("on")
title('R0=1, Theta =1');
cplot = @(r,x0,y0) plot(x0 + r*cos(linspace(0,2*pi)),y0 + r*sin(linspace(0,2*pi)),'-','lineWidth',4);
for i = 1:length(peaks_1_1)
    if peaks_1_1(i,1)~=0||peaks_1_1(i,2)~=0||peaks_1_1(i,3)~=0
        r = 80+peaks_1_1(i,3);
        x = peaks_1_1(i,1);
        y = peaks_1_1(i,2);
        cplot(r,x,y);
    end
end
%%
tic;houghCircles_test = dip_hough_circles(BW22,3,4);toc;
peaks_test = dip_houghpeaks3d(houghCircles_test);
figure();
imshow(norm_img22);
hold("on");
title('R0=3, Theta =4');
for i = 1:length(peaks_test)
    if peaks_test(i,1)~=0||peaks_test(i,2)~=0||peaks_test(i,3)~=0
        r = 80+peaks_test(i,3);
        x = peaks_test(i,1);
        y = peaks_test(i,2);
        cplot(r,x,y);
    end
end

%%
peaks_10_4 = dip_houghpeaks3d(houghCircles_10_4);
figure();
imshow(norm_img22);
hold("on");
title('R0=4, Theta =10');
for i = 1:length(peaks_10_4)
    if peaks_10_4(i,1)~=0||peaks_10_4(i,2)~=0||peaks_10_4(i,3)~=0
        r = 80+peaks_10_4(i,3);
        x = peaks_10_4(i,1);
        y = peaks_10_4(i,2);
        cplot(r,x,y);
    end
end
%%
figure();
subplot(1,3,1);imshow(houghCircles_1_1(:,:,8),[]);colormap("gray");title('R0=1 Theta0=1 R=80');
subplot(1,3,2);imshow(houghCircles_10_4(:,:,2),[]);colormap("gray");title('R0=4 Theta0=10 R=84');
subplot(1,3,3);imshow(houghCircles_test(:,:,3),[]);colormap("gray");title('R0=3 Theta0=4 R=89');




