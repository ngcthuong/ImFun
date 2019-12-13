img1 = imread('img_g_10.jpg');
img2 = imread('img_b_1.jpg');
img3 = abs(img1 - img2)>0;
a = sum(img3(:));
b =a/500^2;
imwrite(img3,'1.jpg');
