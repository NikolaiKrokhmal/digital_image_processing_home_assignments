%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function houghCircles = dip_hough_circles(BW, R0, tta0)
    [M,N] = size(BW);
    Rmin = 80;
    Rmax = 100;
    rVec = Rmin:R0:Rmax;
    houghCircles = zeros(M,N,length(rVec));
    for y = 1:N
        for x=1:M
            if BW(x,y) == 1
                for rIndx = 1:length(rVec)
                   for tta = 0:tta0:359
                       r = rVec(rIndx);
                       a = round(y-r*cosd(tta));
                       b = round(x-r*sind(tta));
                       if(a>0&&b>0&&a<=size(BW,1)&&b<=size(BW,2))
                        houghCircles(a,b,rIndx) = houghCircles(a,b,rIndx) + 1;
                       end
                   end
                end
            end
        end
    end


end