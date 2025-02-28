%Natan Davidov 211685300, Nikolai Krokhmal 320717184

% this main function send to the appropriate one dependeing on "action"
function modImage = adjust_brightness(img,action,parameter)
   if action == "mul"
        modImage = multiple_brightness(img,parameter);
   else
       modImage = add_brightness(img,parameter);
   end
end

% this function multiplies every pixel of img by parameter and trunckes if
% greater the 1 or less then zero
function mulImage = multiple_brightness(img,parameter)
    [rows, cols] = size(img);
    for row = 1:rows
        for col = 1:cols
            img(row,col) = img(row,col)*parameter;
            if img(row,col) > 1
                img(row,col) = 1;
            elseif img(row,col) < 0
                img(row,col) = 0;
            end
        end
    end
    mulImage = img;
end


% this function add to every pixel of img thr parameter and trunckes if
% greater the 1 or less then zero
function addImage = add_brightness(img,parameter)
    [rows, cols] = size(img);
    for row = 1:rows
        for col = 1:cols
            img(row,col) = img(row,col)+parameter;
            if img(row,col) > 1
                img(row,col) = 1;
            elseif img(row,col) < 0
                img(row,col) = 0;
            end
        end
    end
    addImage = img;
end
