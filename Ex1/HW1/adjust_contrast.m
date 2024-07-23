%Natan Davidov 211685300, Nikolai Krokhmal 320717184

% here we adjst the contrust by mapping the active range of the exsiting
% image to the active range of the new one, pixel by pixel, formula at line
% 13
function modImage = adjust_contrast(img,range_low,range_high)
    oldLow = min(img);
    oldHigh = max(img);
    modImage = zeros(size(img));
    [rows, cols] = size(img);
    for row = 1:rows
        for col = 1:cols
            modImage(row,col) = ((img(row,col)-oldLow)*(range_high-range_low))/(oldHigh-oldLow) + range_low;
        end
    end
end