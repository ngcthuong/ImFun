% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by David Chen
% Color balancing example

clear, clc, close all

images = {'grayball.jpg', 'berndsface.jpg'};
targetGrayMean = [0.26 0.2];
figure(1); clf;
for nImage = 1:length(images)
    
    % Open image
    img = im2double(imread(images{nImage}));
    [pathStr, name, ext] = fileparts(images{nImage});
    disp(images{nImage});
    
    % Undo gamma pre-distortion
    gamma = 2.2;
    img = imadjust(img, [0,1], [0,1], gamma);
    subplot(length(images), 7, (nImage-1)*7+1); 
    imshow(img); title('Original Image');
    
    % Perform gray world
    imgCB = color_balancing(img, 'gray-world', [1 1 1], targetGrayMean(nImage));
    imgCB = imadjust(imgCB, [0,1], [0,1], 1/gamma);
    imwrite(imgCB, [name '-gray-world.jpg']);
    subplot(length(images), 7, (nImage-1)*7+2); 
    imshow(imgCB); title('Gray World');
    
    % Perform scale-by-max
    imgCB = color_balancing(img, 'scale-by-max', [1 1 1], targetGrayMean(nImage));
    imgCB = imadjust(imgCB, [0,1], [0,1], 1/gamma);
    imwrite(imgCB, [name '-scale-by-max.jpg']);
    subplot(length(images), 7, (nImage-1)*7+3); 
    imshow(imgCB); title('Scale-by-Max');
    
    % Perform shades-of-gray
    imgCB = color_balancing(img, 'shades-of-gray', [1 1 1], targetGrayMean(nImage));
    imgCB = imadjust(imgCB, [0,1], [0,1], 1/gamma);
    imwrite(imgCB, [name '-shades-of-gray.jpg']);
    subplot(length(images), 7, (nImage-1)*7+4); 
    imshow(imgCB); title('Shades-of-Gray');
    
    % Perform gray-edge
    imgCB = color_balancing(img, 'gray-edge', [1 1 1], targetGrayMean(nImage));
    imgCB = imadjust(imgCB, [0,1], [0,1], 1/gamma);
    imwrite(imgCB, [name '-gray-edge.jpg']);
    subplot(length(images), 7, (nImage-1)*7+5); 
    imshow(imgCB); title('Gray-Edge');
    
    % Perform max-edge
    imgCB = color_balancing(img, 'max-edge', [1 1 1], targetGrayMean(nImage));
    imgCB = imadjust(imgCB, [0,1], [0,1], 1/gamma);
    imwrite(imgCB, [name '-max-edge.jpg']);
    subplot(length(images), 7, (nImage-1)*7+6); 
    imshow(imgCB); title('Max-Edge');
    
end % nImage