clear, clc, close all

% Load test image
img = im2double(imread('croppedBike.png'));
[row, col] = size(img);

% Perform subsampling by matrix multiplication
a = eye(row / 4);
b = [1; 0; 0; 0];
c = [0.25; 0.25; 0.25; 0.25];
H1 = kron(a, b);
H2 = kron(a, c);
subImg1 = H1' * img * H1;
subImg2 = H2' * img * H2;
% Show images
subplot(1, 2, 1), imshow(subImg1); title('Method 1');
subplot(1, 2, 2), imshow(subImg2); title('Method 2');

% Save images
imwrite(subImg1, 'Subsampling_subsample_1.png');
imwrite(subImg2, 'Subsampling_subsample_2.png');



