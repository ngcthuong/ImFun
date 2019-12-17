clear, clc, close all
I = im2double(imread('croppedBike.png'));
figure(1); clf;
imshow(I); title('Original Image');
% Simulate additive noise.
noise_mean = 0;
noise_var = 0.005;
noisy = imnoise(I, 'gaussian', noise_mean, noise_var);
imwrite(noisy, 'Gauss_Filtering_Additive_Noise_noisy.png');
figure;
% imshow(noisy);
dif = 255 * (noisy - I);
rms_error_before_wnr = rms(dif(:));

% Perform Wiener filtering on noisy image
Gauss_mask = my_Gauss_mask(round(sqrt(noise_var)*255));
a = uint8(noisy*255);
imgW = my_Gauss_filter(a, Gauss_mask);
imgMW = imfilter(a, Gauss_mask,'replicate');
imshow(imgW);