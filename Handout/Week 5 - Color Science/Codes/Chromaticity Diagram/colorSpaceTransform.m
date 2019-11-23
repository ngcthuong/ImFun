function outImg = colorSpaceTransform( inImg, M )
[row, col, N] = size(inImg);
mat = [inImg(:, :, 1), inImg(:, :, 2), inImg(:, :, 3)];
mat = reshape(mat, [row * col, 3]);
newMat = (M * mat')';
outImg = reshape(newMat, [row, col, 3]);
end

