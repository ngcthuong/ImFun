% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Example histogram

clear, clc, close all

% Load test image
img = imread('bay.jpg');
[counts, index] = imhist(img);

% Plot histogram
subplot(1, 2, 1), bar(index, counts);
set(gca, 'FontSize', 20); 
xlim([0 255]);
xlabel('Gray level'), ylabel('# pixels');

% Show image
subplot(1, 2, 2), imshow(img);
title('Original image');
saveas(gca, 'Histogram.png');




