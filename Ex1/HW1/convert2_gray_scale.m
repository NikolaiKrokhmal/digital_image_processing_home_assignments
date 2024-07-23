%Natan Davidov 211685300, Nikolai Krokhmal 320717184
function grayScaleImg = convert2_gray_scale(folder, img) %%%
    path = fullfile(folder,img)
    myImage = imread(path);
    grayScaleImg = double(rgb2gray(myImage));
    

end

