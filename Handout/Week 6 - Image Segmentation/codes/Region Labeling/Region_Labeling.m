% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Example: Region labeling

clear, clc, close all

% Load test image
img = imread('fish.png');

% Binarize image
level = graythresh(img);
bwImg = 1- im2bw(img, level);

% Region labeling
L = bwlabel(bwImg, 8);
rgbLabel = label2rgb(L, 'jet', 'k');

% Show images
subplot(1, 3, 1), imshow(img); title('Original Image');
subplot(1, 3, 2), imshow(bwImg); title('Binarized Image');
subplot(1, 3, 3), imshow(rgbLabel); title('Labeled Regions');

% Save images
imwrite(bwImg, 'Region_Labeling_bw.png');
imwrite(rgbLabel, 'Region_Labeling_rgbLabel.png');

