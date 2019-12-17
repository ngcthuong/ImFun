clear, clc, close all
I = im2double(imread('croppedBike.png'));

% Simulate additive noise.
noise_mean = 0;
noise_var = 0.005;
noisy = imnoise(I, 'gaussian', noise_mean, noise_var);
imwrite(noisy, 'Wiener_Filtering_Additive_Noise_noisy.png');
dif = 255 * (noisy - I);
rms_error_before_wnr = rms(dif(:));

% Perform Wiener filtering on noisy image
imgW = my_Wiener_filter(noisy, 0.007);
imwrite(imgW,'Wiener_filter_7.jpg');
dif2 = 255 * (imgW - I);
rms_error_after_wnr = rms(dif2(:));