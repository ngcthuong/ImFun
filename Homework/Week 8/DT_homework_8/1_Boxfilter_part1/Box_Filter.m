clear, clc, close all

% Load test image
img = imread('croppedBike_Gauss_sigma50.png');
% sigma = 50;
% img2 = img + uint8(rand(size(img)) * sigma - sigma / 2);
% imwrite(img2,'croppedBike_Gauss_sigma50.png');
% Apply two different sharpening filters
h1 = ones(3) / 9;
h2 = ones(5) / 25;
h3 = ones(9) / 81;
h4 = ones(25) / 625;

filteredImg1 = mask_kernel_with_replicate(img,h1);

% Save images
imwrite(filteredImg1, 'Box_filter_3_g50.png');
