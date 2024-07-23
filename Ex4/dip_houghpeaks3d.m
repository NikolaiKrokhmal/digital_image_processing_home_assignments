%Natan Davidov 211685300, Nikolai Krokhmal 320717184

function peaks = dip_houghpeaks3d(HoughMatrix)
    peakAmount = 20;
    thresholdCoefficient = 0.6;
    peaks = zeros(peakAmount,3);
    [maxVal ,~] = max(HoughMatrix(:));
    for i=1:peakAmount
        [val, idx] = max(HoughMatrix(:));
        if val > thresholdCoefficient * maxVal
            [idx1, idx2, idx3] = ind2sub(size(HoughMatrix), idx);
            peaks(i ,:) = [idx1, idx2, idx3];
            HoughMatrix(idx1,idx2 ,idx3) = 0;
        end
    end
end