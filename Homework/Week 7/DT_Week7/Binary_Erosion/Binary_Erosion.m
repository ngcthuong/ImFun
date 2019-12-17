clear, clc, close all
img = rgb2gray(imread('butterfly.png'));
% img = imread('bacteria.png');
sel = strel('square', 11);
neighbor = getnhood(sel);
imgB = myerode(img, neighbor);
BW1 = imerode(img,sel);
com = BW1 ~= imgB;
a = sum(sum(com));

imwrite(imgB,'my_Erosion_square_11_2.png');
imwrite(BW1, 'Erosion_square_11_2.png');




