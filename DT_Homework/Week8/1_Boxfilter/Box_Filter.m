clear, clc, close all

% Load test image
img = im2double(imread('img_g_25.jpg'));

% Apply two different sharpening filters
h1 = ones(3) / 9;
h2 = ones(5) / 25;
h3 = ones(9) / 81;
h4 = ones(25) / 625;

filteredImg1 = mask_kernel(img, h1);

% Save images
imwrite(filteredImg1, 'Box_filter_25_g_box3.png');
