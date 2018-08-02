function [ scribble_pts ] = get_scribbles( gray_image, scribbled_image )

scribble_pts = zeros(1, 2);
num = 1;
[height, width, ~] = size(gray_image);
for i = 1 : height
    for j = 1 : width
        if gray_image(i, j, 1) ~= scribbled_image(i, j, 1) || gray_image(i, j, 2) ~= scribbled_image(i, j, 2) || gray_image(i, j, 3) ~= scribbled_image(i, j, 3)
            scribble_pts(num, 1) = i;
            scribble_pts(num, 2) = j;
            num = num + 1;
        end
    end
end

end

