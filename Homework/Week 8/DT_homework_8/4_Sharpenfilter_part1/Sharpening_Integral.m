clear, clc, close all

% Load test image
imgO = imread('croppedBike.png');
load('integral.mat','imgI');
[x, y] = size(imgI);
img = zeros(x-1, y-1);
windowsize = 3;
n = (windowsize - 1)/2;
for a = 1:1000
for i = 1:x-1
    for j = 1:y-1
         img(i,j) = imgI(min(i+n+1,x), min(j+n+1,y)) + imgI(max(i-n,1), max(j-n,1)) - imgI(max(i-n,1), min(j+n+1,y)) - imgI(min(x,i+n+1),max(1,j-n));    
    end
end
end
imgSharp = uint8(10*double(imgO) - img);
% imwrite(imgSharp, 'imgSharp_use_Intergral.png');