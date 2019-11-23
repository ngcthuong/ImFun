% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Locally adaptive thresholding

clear, clc, close all

% Load test image
img = im2double(imread('paper.png'));
%img = imresize(img, [256, 384]); 

% Perform global thresholding with Otsu's method
level = graythresh(img);
globalBwImg = im2bw(img, level);

% Decide local thresholding parameters
[row col] = size(img);
stepSize = 16;
tileSize = 32;
varThresh = 0.0005;

% Perform locally adaptive thresholding
localBwImg = zeros(row, col);
uniformMask = zeros(row, col);
threshIm = zeros(row / stepSize, col / stepSize);
for i = 1: row / stepSize
    % Get indices for row
    rowStep = (i - 1) * stepSize + 1 : i * stepSize;
    rowTile = (i - 1) * stepSize + 1 : (i + 1) * stepSize;
    if i == row / stepSize
        rowTile = (i-2) * stepSize + 1 : i * stepSize;
    end
    
    % Calculate Otsu's threshold for row
    rowThresh = graythresh(img(rowTile, :));
    
    for j = 1: col / stepSize
        % Get indices for column    
        colStep = (j - 1) * stepSize + 1 : j * stepSize;
        colTile = (j - 1) * stepSize + 1 : (j + 1) * stepSize;
        if j == col / stepSize
            colTile = (j - 2) * stepSize + 1 : j * stepSize;
        end

        % Calculate local variance
        step = img(rowStep, colStep); 
        varStep = var(step(:));

        % Calculate local Otsu's threshold
        tile = img(rowTile, colTile);
        localThresh = graythresh(tile);
        
        % Threshold based on local Ostu's threshold
        if (varStep > varThresh)
            localBwImg(rowStep, colStep) = im2bw(step, localThresh);
            uniformMask(rowStep, colStep) = ones(stepSize, stepSize);
            threshIm(i, j) = localThresh;
            
        % Threshold based on local mean
        else
            localMean = mean(tile(:));
            threshIm(i, j) = 0;
            if (localMean > min(rowThresh,level))
                localBwImg(rowStep, colStep) = ones(stepSize, stepSize);
            else
                localBwImg(rowStep, colStep) = zeros(stepSize, stepSize);
            end
            uniformMask(rowStep, colStep) = zeros(stepSize, stepSize);
        end

    end % j
end % i

% Show images
figure(1); clf;
subplot(1,2,1), imshow(globalBwImg), title('Global BW image')
subplot(1,2,2), imshow(localBwImg), title('Local BW image')
figure(2); clf;
subplot(1,2,1), imshow(uniformMask.* img), title('Original image with uniform mask')
subplot(1,2,2), imshow(threshIm), title('Local threshold value image')

% Save images
imwrite(globalBwImg, 'Locally_Adaptive_Thresholding_global.png');
imwrite(localBwImg, 'Locally_Adaptive_Thresholding_local.png');
imwrite(uniformMask.* img, 'Locally_Adaptive_Thresholding_uniformMask.png');
imwrite(kron(threshIm, ones(stepSize)), 'Locally_Adaptive_Thresholding_thresh.png');