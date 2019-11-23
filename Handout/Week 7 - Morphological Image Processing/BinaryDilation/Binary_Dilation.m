% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Dilation

clear, clc, close all

% Load test image
img = imread('bacteria.png');

% Perform dilation with small disk
se1 = strel('disk', 10);
BW1 = imdilate(img,se1);

% Perform dilation with larger disk
se2 = strel('disk', 20);
BW2 = imdilate(img, se2);

% Show images
subplot(1, 3, 1), imshow(img); title('Original Image');
subplot(1, 3, 2), imshow(BW1); title('Dilation by Small Disk');
subplot(1, 3, 3), imshow(BW2); title('Dilation by Larger Disk');

% Save images
imwrite(BW1, 'Dilation_disk_10.png');
imwrite(BW2, 'Dilation_disk_20.png')





