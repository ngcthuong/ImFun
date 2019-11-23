function outputImg = flipImage( inputImg )
outputImg = zeros(size(inputImg));
outputImg(:, :, 1) = flipud(inputImg(:, :, 1));
outputImg(:, :, 2) = flipud(inputImg(:, :, 2));
outputImg(:, :, 3) = flipud(inputImg(:, :, 3));
end

