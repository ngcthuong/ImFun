clear, clc, close all

% Load test image
img = imread('01.jpg');
img = rgb2gray(img);
%imwrite(img, 'gray.jpg');

% Filter by Gaussian
sigma = 50;
g = fspecial('gaussian', [4*sigma+1 4*sigma+1], sigma);
img_g = imfilter(img, g, 'replicate');
% figure(4); clf;
% imshow(img_g); title('Filtered by Gaussian');
 imwrite(img_g, 'img_g_50.jpg');

% % Filter by box
% [X,Y] = meshgrid(-5*sigma:5*sigma, -5*sigma:5*sigma);
% N = 1000;
% w = sqrt(12 * sigma^2 / N);
% b = double(abs(X) < w/2) .* double(abs(Y) < w/2);
% b = b/sum(b(:));
% img_b = img;
% for n = 1:N
%     img_b = imfilter(img_b, b, 'replicate');
% %     figure(4+n); clf;
% %     imshow(img_b); 
% %     if n == 1
% %         title(sprintf('Filtered by %d Box', n));
% %     else
% %         title(sprintf('Filtered by %d Boxes', n));
% %     end
%     
% end % 
% imwrite(img_b, sprintf('img_b_%d.jpg', N));