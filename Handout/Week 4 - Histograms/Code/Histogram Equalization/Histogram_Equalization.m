% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Histogram equalization example

clear, clc, close all

% Load test image
img = imread('bay.jpg');
% img = imread('brain.jpg');
% img = imread('moon.jpg');

% Perform histogram equalization
eqImg = histeq(img);

% Show images
figure(1), clf;
subplot(1, 2, 1), imshow(img), title('Original image');
subplot(1, 2, 2), imshow(eqImg), title('After histogram equalization');
imwrite(eqImg, 'Histogram_Equalization_eqImg.png');

% Show histogram for original image
[counts, index] = imhist(img);
figure(2), clf;
subplot(1, 2, 1), bar(index, counts);
xlim([0 255]);
set(gca, 'FontSize', 20); 
xlabel('Gray level');
ylabel('# pixels')
title('Histogram of original image');

% Show histogram for histogram-equalized image
[counts, index] = imhist(eqImg);
subplot(1, 2, 2), bar(index, counts);
xlim([0 255]);
set(gca, 'FontSize', 20); 
xlabel('Gray level');
ylabel('# pixels');
title('Histogram of equalized image');


