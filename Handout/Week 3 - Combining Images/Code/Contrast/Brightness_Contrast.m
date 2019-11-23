% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Brightness Adjustment and Contrast Adjustment

clear, clc, close all

% Load test image
img = im2double(imread('parrot.jpg'));

%% Brightness adjustment by intensity scaling
scale = 1.2;
scaledImg = scale .* img;
subplot(1, 2, 1), imshow(img, [0, 1]);
title('Original image');
subplot(1, 2, 2), imshow(scaledImg, [0, 1]);
title('Scaled image');
imwrite(scaledImg, 'chap2_Brightness_scaled.png');

%% Contrast adjustment by changing "gamma"
gamma = 1.5;
gammaImg = img.^gamma;
figure;
subplot(1, 2, 1), imshow(img);
title('Original image');
subplot(1, 2, 2), imshow(gammaImg);
title('\gamma increased by 50%');
imwrite(gammaImg, 'Contrast_gamma.png');



