img = rgb2gray(imread('1.png'));
level = graythresh(img);
bwImg = im2bw(img, level);
imshow(myMorphologicalEdgeDetector(bwImg));