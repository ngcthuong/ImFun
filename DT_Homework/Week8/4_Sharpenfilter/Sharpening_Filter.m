clear, clc, close all

% Load test image
img = im2double(imread('croppedBike.png'));

% Apply two different sharpening filters
h1 = [0, -1, 0; -1, 8, -1; 0, -1, 0] / 4;
filteredImg1 = mask_kernel(img, h1);
filterMatlabImg = imfilter(img, h1,'replicate');
a = sum(sum(filteredImg1 - filterMatlabImg));
% Show images
figure(1), clf;
subplot(1, 2, 1), imshow(img); title('Original Image');
subplot(1, 2, 2), imshow(filteredImg1); title('Filtered Image');

% Save images
imwrite(filteredImg1, 'Sharpening_Filter_Naive.png');
imwrite(filterMatlabImg, 'Sharpening_by_Matlab.png');