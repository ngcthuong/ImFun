function imgGrad = gradient_magnitude(img)
% -Input-
% img: rgb image
%
% -Output-
% imgGrad: gradient magnitude image

[rows, cols, channels] = size(img);
imgGrad = zeros(size(img));
sigma = 1;
for i = 1:3
    pix = reshape(img(:,:,i), rows, cols);
    pix = imfilter(pix, fspecial('gaussian', [5*sigma 5*sigma], sigma));
    pix_dx = imfilter(pix, fspecial('sobel'));
    pix_dy = imfilter(pix, fspecial('sobel').');
    imgGrad(:,:,i) = sqrt(pix_dx.^2 + pix_dy.^2);
end % i