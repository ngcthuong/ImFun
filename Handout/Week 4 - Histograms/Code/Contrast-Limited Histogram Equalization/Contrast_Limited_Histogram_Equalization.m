% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Contrast-limited histogram equalization

clear, clc, close all

% Load test image
img = imread('moon.jpg');
[counts, index] = imhist(img);
maxCount = max(counts(:));

% Loop over clip ratios
clipRatio = [1; 0.7; 0.4; 0.1]; % Ratio 1 means no clipping
limitEqImg = cell(1, numel(clipRatio));
LUT = uint8(zeros(numel(clipRatio), 256));
for i = 1 : numel(clipRatio)
    % Clip histogram
    clip = clipRatio(i) * maxCount;
    clippedCounts = (counts < clip) .* counts + (counts >=clip) * clip;
    
    % Construct a 1 dimensional virtual image for histeq to get mapping
    % function
    clippedImg = []; 
    for level = 0 : 255
        clippedImg = cat(2, clippedImg, level * ones(1, clippedCounts(level + 1)));
    end
    [temp, T] = histeq(uint8(clippedImg));
    
    % Apply mapping function
    LUT(i, :)= uint8(T * 255);
    limitEqImg{i} = intlut(img, LUT(i, :));
end 

% Show images
figure(1), clf;
for i = 1 : numel(clipRatio)
    subplot(1, numel(clipRatio), i), imshow(limitEqImg{i});
    title(['Clip at ' num2str(clipRatio(i)) '*max']);
    imwrite(limitEqImg{i}, ['CLHE_ratio' num2str(clipRatio(i)) '.png'])
end

%%
% Show histogram and mapping function
figure(2), clf;
set(gcf, 'Position', [100 100 600 290]);
subplot(1, 2, 1), 
bar(index, counts), axis([0 255 0 120000]);
% xlabel('Gray level'); ylabel('Count');
set(gca, 'FontSize', 16); 
subplot(1, 2, 2), plot(LUT(1:4,:)', 'LineWidth', 2);
% legend(['Clip limit = ' num2str(clipRatio(1))], ['Clip limit = ' num2str(clipRatio(2))], ...
%               ['Clip limit = ' num2str(clipRatio(3))], 'Original histogram', ...
%               'Location', 'SouthEast');
% title('Mapping functions');
% xlabel('Input gray level'); ylabel('Output gray level');
axis([0 255 0 255]);
set(gca, 'FontSize', 16); 
set(gcf, 'Color', 'white');

