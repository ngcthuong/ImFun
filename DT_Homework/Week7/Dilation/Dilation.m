clear, clc, close all
img = rgb2gray(imread('butterfly.png'));
sel = strel('disk', 3);
neighbor = getnhood(sel);
imgB = mydilate(img, neighbor);
BW1 = imdilate(img,sel);
com = BW1 ~= imgB;
a = sum(sum(com));
imwrite(imgB, 'my_Dilation_disk_3_2.png');
imwrite(BW1, 'Dilation_disk_3_2.png');




