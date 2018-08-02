function [ w ] = weight2( r, s, sig, average )

% r and s are intensities Y(r) and Y(s).
% neighbors is a list of intensities of r's neighboring pixels.
w = 1 + (1 / sig) * (r - average) * (s - average);

end

