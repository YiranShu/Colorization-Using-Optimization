function [ neighbors ] = get_neighbors( row, column, height, width )
% return a list of coodinates of neighboring pixels of im(row,column)

if (row == 1 && column == 1) || (row == 1 && column == width) || (row == height && column == 1) || (row == height && column == width)
    neighbors = zeros(3, 2);
elseif row == 1 || row == height || column == 1 || column == width
    neighbors = zeros(5, 2);
else
    neighbors = zeros(8, 2);
end

index = 1;
for i = row - 1 : row + 1
    for j = column - 1 : column + 1
        if i >= 1 && i <= height && j >= 1 && j <= width && (i ~= row || j ~= column)
            neighbors(index, 1) = i;
            neighbors(index, 2) = j;
            index = index + 1;
        end
    end
end

end

