function [ weights ] = get_weights1( r, neighbors_intensities )

[~, num] = size(neighbors_intensities);
window = double([neighbors_intensities, r]);
[sig, ~] = get_sig(window);
weights = zeros(1, num);
for i = 1 : num
    weights(i) = weight1(r, neighbors_intensities(i), sig);
end

end

