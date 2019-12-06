img1 = imread('img_g.jpg');
img2 = imread('img_b_1000.jpg');
img3 = abs(img1 - img2);
imwrite(img3,'1000.jpg');
