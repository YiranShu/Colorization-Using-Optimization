function [ w ] = weight1( r, s, sig )

% r and s are intensities Y(r) and Y(s).
% sig is the variance of the window.
diff = double(r - s);
w = exp(-diff ^ 2 / 2 * sig);

end

