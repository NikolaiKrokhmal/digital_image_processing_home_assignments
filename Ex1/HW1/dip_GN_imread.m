%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function normalizedGrayScale = dip_GN_imread(filename)
   path = fullfile('Images',filename);
   grayScale = double(rgb2gray(imread(path))); % make gray scale image
   minImg = min(grayScale(:));
   maxImg = max(grayScale(:));
   normalizedGrayScale = ((grayScale-minImg)/(maxImg-minImg)); % here we 
   % normalize the values of the pixels
end