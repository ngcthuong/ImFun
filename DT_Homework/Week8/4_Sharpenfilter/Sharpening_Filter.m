clear, clc, close all

% Load test image
img = imread('croppedBike.png');

% Apply two different sharpening filters
h1 = [-1, -1, -1; -1, 9, -1; -1, -1, -1];
for a=1:1000
filteredImg1 = mask_kernel(img, h1);
end
% filterMatlabImg = imfilter(img, h1);

% Save images
% imwrite(filteredImg1, 'Sharpening_Filter_Naive.png');
% imwrite(filterMatlabImg, 'Sharpening_by_Matlab.png');