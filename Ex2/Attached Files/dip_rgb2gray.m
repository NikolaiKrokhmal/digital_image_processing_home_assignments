%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function grayScale = dip_rgb2gray(redCh, greenCh, blueCh)
    grayScale = 0.2989*redCh + 0.5870*greenCh + 0.1140*blueCh;
end