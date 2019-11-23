% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Quantization: how many bits per pixel?

clear, clc, close all;

% Load test image
img = double(imread('face.jpg'));

% Loop over number of bits
for numOfBit = 1 : 8
    % Quantize to given number of bits
    numOfLevel = 2.^ numOfBit;
    levelGap = 256 / numOfLevel;
    quantizedImg = uint8(ceil(img / levelGap) * levelGap - 1); % quantization
   
    % Plot image
    subplot(2, 4, 9 - numOfBit), imshow(quantizedImg);
    if numOfBit == 1
        name = [num2str(numOfBit) '-bit'];
    else
        name = [num2str(numOfBit) '-bits'];
    end
    title(name);
    
    % Save image
    imwrite(quantizedImg, ['Quantization_' name '.png'] );
end %end numOfBit
