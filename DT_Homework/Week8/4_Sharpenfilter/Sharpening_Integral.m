clear, clc, close all

% Load test image
img = im2double(imread('croppedBike.png'));

imgI = integral_img(img);
