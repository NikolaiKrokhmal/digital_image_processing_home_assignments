%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function new_hist= dip_histogram(image, nbins)
img = imread(image);  % here we read img and make it grayscale
img = double(rgb2gray(img));
n = numel(img);
hist_vec = zeros(1, 256);
mat2vec = reshape(img, 1, []); % we reshape it into a vector to iterate 
% over and build a histogram
for i = 1:1:n
    hist_vec(mat2vec(i)+1) = hist_vec(mat2vec(i)+1) + 1;    
end
mySections = get_sections(nbins); % we get the sections from our sections
    % function
new_hist = zeros(1, nbins);
for j = 1:1:nbins % now we calculate the new histogram summing the amount
    % of pixels in each bin
    for i = mySections(j*2-1):mySections(j*2)
        new_hist(j) = new_hist(j) + hist_vec(i);
    end
end
end


function secVec = get_sections(nbins) % this function creates a vector 
% with the section borders for each bin
    secVec = ones(1,2*nbins);
    for i = 1:nbins
        secVec(i*2) = floor(256*i/nbins);
    end
    for j = 3:2:2*nbins-1
        secVec(j) = secVec(j-1) +1;
    end
end







