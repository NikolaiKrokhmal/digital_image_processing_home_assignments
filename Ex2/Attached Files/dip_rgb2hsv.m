%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function hsvImage = dip_rgb2hsv(image)
    image = double(image);
    [rows, cols, pixel] = size(image);
    hsvImage = zeros(rows,cols,pixel);
    for row = 1:rows
        for col = 1:cols
            hue = getHue(reshape(image(row,col,:),1,[]));
            sat = getSat(reshape(image(row,col,:),1,[]));
            val = getVal(reshape(image(row,col,:),1,[]));
            hsvImage(row,col,1) = hue/360;
            hsvImage(row,col,2) = sat;
            hsvImage(row,col,3) = val;
        end
    end
end

function hue = getHue(pixel)
    r = pixel(1)/255;
    g = pixel(2)/255;
    b = pixel(3)/255;
    cMax = max([r,g,b]);
    cMin = min([r,g,b]);
    deltaC = cMax - cMin;
    if deltaC == 0
        hue = 0;
    elseif cMax == r
        hue = 60*mod(((g-b)/deltaC),6);
    elseif cMax == g
        hue = (2+((b-r)/deltaC))*60;
    else
        hue = (((r-g)/deltaC)+4)*60;
    end
end

function sat = getSat(pixel)
    r = pixel(1)/255;
    g = pixel(2)/255;
    b = pixel(3)/255;
    cMax = max([r,g,b]);
    cMin = min([r,g,b]);
    deltaC = cMax - cMin;
    if cMax == 0
        sat = 0;
    else
        sat = deltaC/cMax;
    end
end

function val = getVal(pixel)
    r = pixel(1)/255;
    g = pixel(2)/255;
    b = pixel(3)/255;
    val = max([r,g,b]);
end

