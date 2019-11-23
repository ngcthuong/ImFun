% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Gray-level thresholding

clear, clc, close all

% Load test image
img = imread('peter.png');

% Threshold
level = 105;
bwImg = img < level;
holeImg = img .* uint8(bwImg);

% Show images
subplot(1, 3, 1), imshow(img); title('Original Image');
subplot(1, 3, 2), imshow(bwImg); title('Thresholded Image');
subplot(1, 3, 3), imshow(holeImg); title('Binary Map \times Original');

% Save images
imwrite(bwImg, 'Graylevel_Thresholding_thresholded.png');
imwrite(holeImg, 'Graylevel_Thresholding_blend.png');







