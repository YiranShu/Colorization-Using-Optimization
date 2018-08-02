function [ output_image, A ] = colorize_using_optimization( gray_image, scribbled_image )

[imh, imw, ~] = size(gray_image);

scribble_pts = get_scribbles(gray_image, scribbled_image);
ycbcr_gray_image = rgb2ntsc(gray_image);
ycbcr_scribbled_image = rgb2ntsc(scribbled_image);
y = ycbcr_gray_image(:, :, 1);

im2var = zeros(imh, imw);
im2var(1: imh * imw) = 1: imh * imw;
e = 0;

[num_scribbles, ~] = size(scribble_pts);
%A = sparse([], [], [], imh * imw + num_scribbles, imh * imw, 4 * 4 + (imh - 2) * 2 * 6 + (imw - 2) * 2 * 6 + (imh - 2) * (imw - 2) * 9);
%A = sparse([], [], [], 4 * 3 + (imh - 2) * 2 * 5 + (imw - 2) * 2 * 5 + (imh - 2) * (imw - 2) * 8 + num_scribbles, imh * imw, 4 * 4 + (imh - 2) * 2 * 6 + (imw - 2) * 2 * 6 + (imh - 2) * (imw - 2) * 9);
%B = sparse([], [], [], imh * imw + num_scribbles, imh * imw, 4 * 4 + (imh - 2) * 2 * 6 + (imw - 2) * 2 * 6 + (imh - 2) * (imw - 2) * 9);
A = sparse([], [], [], imh * imw + 1, imh * imw, 4 * 4 + (imh - 2) * 2 * 6 + (imw - 2) * 2 * 6 + (imh - 2) * (imw - 2) * 9 - 3 * num_scribbles + imh * imw);
b = zeros(imh * imw + 1, 1);
c = zeros(imh * imw + 1, 1);

for i = 1 : imh
    for j = 1 : imw
        [exist, ~] = ismember([i, j], scribble_pts, 'rows');
        if exist
            e = e + 1;
            A(e, im2var(i, j)) = 1;
            b(e) = ycbcr_scribbled_image(i, j, 2);
            c(e) = ycbcr_scribbled_image(i, j, 3);
        else
            neighbors = get_neighbors(i, j, imh, imw);
            neighbors_intensities = get_neighbors_intensities(y, neighbors);
            weights = get_weights1(y(i, j), neighbors_intensities);
            sum_weight = sum(weights);
        
            e = e + 1;
            index_weights = 0;
            A(e, im2var(i, j)) = 1;
            for ii = i - 1 : i + 1
                for jj = j - 1 : j + 1
                    if ii >= 1 && ii <= imh && jj >= 1 && jj <= imw && (ii ~= i || jj ~= j)
                        index_weights = index_weights + 1;
                        A(e, im2var(ii, jj)) = -weights(index_weights) / sum_weight;
                    end
                end
            end
        end
        
    end
end

%for i = 1 : imh * imw
%    if A(i, i) <= 1e-6
%        A(i, i) = 1e-6;
%    end
%end

%B = A;
%for i = 1 : num_scribbles
%    e = e + 1;
%    A(e, im2var(scribble_pts(i, 1), scribble_pts(i, 2))) = 1;
%    b(e) = ycbcr_scribbled_image(scribble_pts(i, 1), scribble_pts(i, 2), 2);
%end
cb = A\b;
cb = reshape(cb, [imh, imw]);

%e = e - num_scribbles;
%for i = 1 : num_scribbles
%    e = e + 1;
%    B(e, im2var(scribble_pts(i, 1), scribble_pts(i, 2))) = 1;
%    b(e) = ycbcr_scribbled_image(scribble_pts(i, 1), scribble_pts(i, 2), 3);
%end

cr = A\c;
cr = reshape(cr, [imh, imw]);

output_image(:, :, 1) = y;
output_image(:, :, 2) = cb;
output_image(:, :, 3) = cr;

output_image = ntsc2rgb(output_image);

end

