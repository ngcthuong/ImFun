clear, clc, close all

% Load test image
img = imread('01.jpg');
img = rgb2gray(img);
% Filter by Gaussian
sigma = 10;
g = fspecial('gaussian', [4*sigma+1 4*sigma+1], sigma);
img_g = imfilter(img, g, 'replicate');
imwrite(img_g, 'img_g_10.jpg');

% Filter by box
[X,Y] = meshgrid(-5*sigma:5*sigma, -5*sigma:5*sigma);
N = 100;
w = sqrt(12 * sigma^2 / N);
b = double(abs(X) < w/2) .* double(abs(Y) < w/2);
b = b/sum(b(:));
img_b = img;
for n = 1:N
    img_b = imfilter(img_b, b, 'replicate');
end 
imwrite(img_b, sprintf('img_b_%d.jpg', N));