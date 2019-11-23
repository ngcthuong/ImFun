% demo 
close all 
im = imread('img.png'); 
imshow(im, []); 

% enhance brightness of image 
count = 1;
for i = 1:0.5:5
    figure(i); imshow(im .^i, [])
end

%eqImg = adapthisteq(img);
imshow(eqImg, []); 