% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Global thresholding with Otsu's method

clear, clc, close all

% Load test image
% img = imread('peter.png');
% img = imread('brain.jpg');
% img = rgb2gray(imread('news.png'));
% img = rgb2gray(imread('front.png'));
img = imread('paper.png');

% Perform Otsu thresholding
level = graythresh(img); % chooses Otsu threshold
otsuThresh = round(level * 255)
bwImg = im2bw(img, level);

% Show images
subplot(1, 3, 1), imshow(img); title('Original Image');
subplot(1, 3, 2), imshow(bwImg); title('Globally Thresholded Image');
subplot(1, 3, 3), imshow((1-bwImg) .* im2double(img)); title('Overlay');
axes('Parent', figure, 'FontSize', 18);
[counts,x] = imhist(img);
bar(x, counts); hold on;
h = plot(otsuThresh*ones(1,100), linspace(0,max(counts)), 'r-');
% title('Graylevel Histogram');
axis([0 255 0 max(counts)]);
set(gca, 'FontSize', 18);
set(gcf, 'Color', 'white');

% Save images
imwrite(bwImg, 'Global_Thresholding_bw.png');
saveas(gcf, 'Global_Thresholding_hist.png')







