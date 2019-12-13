clear, clc, close all

% Load test image
imgO = imread('1.png');
% img = imgO(:,:,1);
% img = rgb2gray(img-imgO);
img = rgb2gray(imread('1.png'));

% Binarize image
level = graythresh(img);
bwImg = im2bw(img, level);
se = strel('disk',5);
ne =  getnhood(se);

for i = 1:1
    bwImg = mydilate(bwImg, ne);
end
for i = 1:1
    bwImg = myerode(bwImg, ne);
end
% Region labeling
L = bwlabel(bwImg, 8);

[~, L] = areaFilter(L, 1000000, 40);
[count, L] = eccentricityFilter(L, 1, 0.5);
rgbLabel = label2rgb(L, 'jet', 'k');

% Show images
subplot(1, 3, 1), imshow(imgO); title('Original Image');
subplot(1, 3, 2), imshow(bwImg); title('Binarized Image');
subplot(1, 3, 3), imshow(rgbLabel); title('Labeled Regions');

% Save images
imwrite(rgbLabel, 'Region_Labeling_rgbLabel_disk5_2.png');

