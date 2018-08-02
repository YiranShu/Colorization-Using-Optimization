function [ output_intensities ] = get_neighbors_intensities( y, neighbors )

[num, ~] = size(neighbors);
output_intensities = zeros(1, num);
for i = 1 : num
    output_intensities(i) = y(neighbors(i, 1), neighbors(i, 2));
end

end

