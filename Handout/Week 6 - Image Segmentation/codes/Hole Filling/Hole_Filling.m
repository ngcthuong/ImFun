% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Hole filling as dual to small region removal

clear, clc, close all

% Load test image
img = imread('face.png');

% Binarize image
level = 105;
bwImg = img < level;
filledBwImg = imfill(bwImg, 'holes');

% Show images
subplot(1, 2, 1), imshow(bwImg); title('Original Binary Image');
subplot(1, 2, 2), imshow(filledBwImg); title('Filled Binary Image');

% Save images
imwrite(bwImg, 'Hole_Filling_bw.png');
imwrite(filledBwImg, 'Hole_Filling_filled.png');





