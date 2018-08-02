function [ weights ] = get_weights2( r, neighbors_intensities )

[~, num] = size(neighbors_intensities);
window = [neighbors_intensities, r];
[sig, average] = get_sig(window);
weights = zeros(1, num);
for i = 1 : num
    weights(i) = weight2(r, neighbors_intensities(i), sig, average);
end

end

