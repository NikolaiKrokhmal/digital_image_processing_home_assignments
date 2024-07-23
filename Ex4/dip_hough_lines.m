%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function edgeImg = dip_hough_lines(BW,R0,tta0)
    [N, M] = size(BW);
    % constructiong the R and Theta vectors which define the accumulation matrix size
    rMax = sqrt((N^2)+(M^2));
    R_vec = -round(rMax) : R0 : round(rMax); 
    tta_vec = -90 : tta0 : 90;
    lenR = length(R_vec);
    lenTTA = length(tta_vec);
    %constructing accumulation matrix
    edgeImg = zeros(lenR,lenTTA);
    % voting for edges
    for y = 1:M
        for x = 1:N
            if BW(y,x) == 1
                for ttaIndx = 1:lenTTA
                    tta = tta_vec(ttaIndx);
                    r = round(x*cosd(tta)+y*sind(tta)); %calculate r for x,y of the edge pixel and all angles
                    [~, rIndx] = min(abs(R_vec-r)); % find the best r index in the matrix
                    edgeImg(rIndx,ttaIndx) =  edgeImg(rIndx,ttaIndx) + 1; %cast vote to bin
                end
            end
        end
    end

    
end