% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Adaptive histogram equalization

clear, clc, close all

% Load test image
img = imread('parrot.jpg');
% img = imread('dental.jpg');
% img = imread('skull.jpg');

% Apply global and adaptive histogram equalization
eqImg = histeq(img);
claheImg1 = adapthisteq(img, 'NumTiles', [8 8]);
claheImg2 = adapthisteq(img, 'NumTiles', [16 16]);

% Show images
figure;
subplot(2, 2, 1), imshow(img), title('Original image');
subplot(2, 2, 2), imshow(eqImg), title('Global histogram');
subplot(2, 2, 3), imshow(claheImg1), title('Tiling 8*8 histograms');
subplot(2, 2, 4), imshow(claheImg2), title('Tiling 16*16 histograms');

% Save images
imwrite(eqImg, 'CLAHE_global.png');
imwrite(claheImg1, 'CLAHE_8by8.png');
imwrite(claheImg2, 'CLAHE_16by16.png');