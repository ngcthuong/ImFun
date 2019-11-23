% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by David Chen
% Example: Detecting bar codes

clc; clear all, close all;

images = {'book.png'};
for nImage = 1:length(images)

    % Load image
    [pathStr, name, ext] = fileparts(images{nImage});
    img = imread(images{nImage});
    
    % Define parameters for local Otsu
    winSize = 32;
    stepSize = 16;
    heightCrop = floor(size(img,1) / winSize) * winSize;
    widthCrop = floor(size(img,2) / winSize) * winSize;
    img = img(1:heightCrop, 1:widthCrop, :);
    imgGray = rgb2gray(img);
    imgDouble = double(img);
    imgGrayDouble = double(imgGray);

    figure(1); clf;
    set(gcf, 'Position', [100 100 300 200]);
    imshow(img); title('Original Image');
    imwrite(img, [name '-cropped.jpg']);

    % Adaptive binarization
    localThresh = 60;
    [imgBW, localUsed, localThresh] = localAdaptiveOtsu(imgGray, winSize, stepSize, localThresh);
    imgBW = 1 - imgBW;
    
    figure(2); clf;
    set(gcf, 'Position', [150 150 300 200]);
    subplot(2,2,1); imshow(imgBW); title('Binarized Image');
    subplot(2,2,2); imshow(localThresh, [0 255]); title('Local Thresholds');
    subplot(2,2,3); imshow(localUsed); title('Local versus Global Thresholded Tiles');
    imwrite(imgBW, [name '-binarize.jpg']);

    % Keep eccentric blobs
    imgBWLabel = bwlabel(imgBW);
    shapeProps = regionprops(imgBWLabel, 'MajorAxisLength', 'MinorAxisLength');
    for nRegion = 1:length(shapeProps)
        idx = find(imgBWLabel == nRegion);
        eccentricity = shapeProps(nRegion).MajorAxisLength / shapeProps(nRegion).MinorAxisLength;
        if eccentricity < 5
            imgBW(idx) = 0;
        end
    end % nRegion

    figure(3); clf;
    set(gcf, 'Position', [200 200 300 200]);
    imshow(imgBW); title('Eccentric Blobs');
    imwrite(imgBW, [name '-binarize-eccentricity.jpg']);

    % Find major axis length histogram
    imgBWLabel = bwlabel(imgBW);
    shapeProps = regionprops(imgBWLabel, 'MajorAxisLength');
    majorLengths = zeros(1, length(shapeProps));
    for nRegion = 1:length(shapeProps)
        majorLengths(nRegion) = shapeProps(nRegion).MajorAxisLength;
    end % nRegion
    histBins = linspace(0, max(majorLengths));
    majorHist = hist(majorLengths, histBins);
    [maxHist, maxHistIdx] = max(majorHist);
    maxMajorLength = histBins(maxHistIdx);

    figure(4); clf;
    set(gcf, 'Position', [250 250 200 150]);
    bar(histBins, majorHist); grid on;
    axis([min(histBins) 0.5*max(histBins) 0 1.2*maxHist]);
    xlabel('Major Axis Length'); ylabel('# Blobs');

    % Keep blobs with major axis length close to histogram-peak length
    for nRegion = 1:length(shapeProps)
        idx = find(imgBWLabel == nRegion);
        if abs(shapeProps(nRegion).MajorAxisLength - maxMajorLength) > 0.4*maxMajorLength
            imgBW(idx) = 0;
        end
    end % nRegion

    figure(5); clf;
    set(gcf, 'Position', [300 300 300 200]);
    imshow(imgBW); title('Filtered by Major Axis Length');
    imwrite(imgBW, [name '-binarize-length.jpg']);
    
    % Find angle histogram
    imgBWLabel = bwlabel(imgBW);
    shapeProps = regionprops(imgBWLabel, 'Orientation');
    orientations = zeros(1, length(shapeProps));
    for nRegion = 1:length(shapeProps)
        orientations(nRegion) = shapeProps(nRegion).Orientation;
    end % nRegion
    histBins = linspace(-90, 90);
    orientationHist = hist(orientations, histBins);
    [maxHist, maxHistIdx] = max(orientationHist);
    maxAngle = histBins(maxHistIdx);

    figure(6); clf;
    set(gcf, 'Position', [350 350 200 150]);
    bar(histBins, orientationHist);
    grid on;
    axis([min(histBins) max(histBins) 0 1.2*maxHist]);
    xlabel('Orientation (degrees)'); ylabel('# Blobs');

    % Keep blobs with orientation close to histogram-peak orientation
    for nRegion = 1:length(shapeProps)
        idx = find(imgBWLabel == nRegion);
        if abs(shapeProps(nRegion).Orientation - maxAngle) > 14
            imgBW(idx) = 0;
        end
    end % nRegion

    figure(7); clf;
    set(gcf, 'Position', [400 400 300 200]);
    imshow(imgBW); title('Filtered by Orientation');
    imwrite(imgBW, [name '-binarize-angle.jpg']);

end % nImage