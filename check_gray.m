function [ output ] = check_gray( im )

[height, width, ~] = size(im);
for i = 1: height
    for j = 1 : width
        if im(i, j, 1) == im(i, j, 2) && im(i, j, 1) == im(i, j, 3) && im(i, j, 2) == im(i, j, 3)
            continue;
        else
            output = 0;
            return;
        end
    end
end

output = 1;

end

