% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University

% Script by Qiyuan Tian and David Chen
% Canny edge detector

clear, clc, close all

% Load test image
img = rgb2gray(imread('1.png'));
level = graythresh(img);
img = im2bw(img, level);
% Loop over different standard deviations of Gaussian
sigmaArray = [sqrt(2), sqrt(8), sqrt(32)];
thresh = 0.3;
figure(1), clf;
subplot(2, 2, 1), imshow(img); title('Original');
for i = 1 : numel(sigmaArray)
    % Compute and show Canny edges
    sigma = sigmaArray(i);
    bw = edge(img, 'canny', thresh, sigma); 
    subplot(2, 2, i + 1), imshow(bw); title(sprintf('sigma = %.2f', sigma));
end % end i











