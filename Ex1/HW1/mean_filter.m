%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function mean_filtered_img = mean_filter(img, k)
    %% Zero padding

    % Zero pad the image using integer k for kernel size
    sz = size(img);
    imgPadded = zeros(sz(1)+(k-1), sz(2)+(k-1));
    imgPadded(((floor((k-1)/2)):(sz(1))+(floor((k-1)/2)-1)), (((floor((k-1)/2)):(sz(2))+(floor((k-1)/2)-1)))) = img;


    % Mean filtering
    %X = ones(k);
    mean_filtered_img = zeros(size(img));  % Pre-allocate output image
    for row = 1:size(img, 1)
        for col = 1:size(img, 2)
            % Define neighborhood for filtering
            rowStart = row;
            rowEnd = row + k - 1;
            colStart = col;
            colEnd = col + k - 1;

            % Extract neighborhood and handle boundary cases
            neighborhood = imgPadded(rowStart:rowEnd, colStart:colEnd);

            % Calculate mean of non-zero elements in the neighborhood
            mean_value = mean(neighborhood(:));

            % Assign mean value to the output image
            mean_filtered_img(row, col) = mean_value;
        end
    end
end
