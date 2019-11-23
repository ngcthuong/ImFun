% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% MAP detector in RGB-space

clear; clc; close all

% Load training and testing images
numTraining = 5;
imgTrain = cell(1, numTraining);
imgTrainMask = cell(1, numTraining);
for i = 1:numTraining
    imgTrain{i} = imread(sprintf('Face_Training_%d.jpg', i));
    imgTrainMask{i} = imread(sprintf('Face_ref_%d.png', i));
end % i
numTesting = 2;
imgTest = cell(1, numTesting);
for i = 1:numTesting
    imgTest{i} = imread(sprintf('Face_Test_%d.jpg', i));
end % i

%% Perform training

% Initialize counters
step = 16;
centroids1D = step/2 : step : 256;
numCentroids1D = numel(centroids1D);
countsFace3D = zeros(numCentroids1D, numCentroids1D, numCentroids1D);
countsNonFace3D = zeros(numCentroids1D, numCentroids1D, numCentroids1D);

% Accumulate counts
for nImage = 1 : numTraining
    disp(sprintf('Processing training image %d', nImage));
    [height, width, channels] = size(imgTrain{nImage});
    for y = 1 : height
        for x = 1 : width
            pix = imgTrain{nImage}(y,x,:);
            for c = 1 : channels
                [minDist, idxRGB(c)] = min(abs(double(pix(c)) - centroids1D));
            end % end c

            if (imgTrainMask{nImage}(y,x) == 1)
                N = countsFace3D(idxRGB(1), idxRGB(2), idxRGB(3));
                countsFace3D(idxRGB(1), idxRGB(2), idxRGB(3)) = N + 1;
            else
                N = countsNonFace3D(idxRGB(1), idxRGB(2), idxRGB(3));
                countsNonFace3D(idxRGB(1), idxRGB(2), idxRGB(3)) = N + 1;
            end
        end % end x
    end % end y
end % end nImage

% Build MAP classifier
centroidClass = countsFace3D > countsNonFace3D;

%% Plot training samples

% Collect samples
numSkinSamples = 0;
numNonSkinSamples = 0;
for nImage = 1:5
    numSkinSamples = numSkinSamples + numel(find(imgTrainMask{nImage} == 1));
    numNonSkinSamples = numNonSkinSamples + numel(find(imgTrainMask{nImage} == 0));
end % nImage
RGBSkin = zeros(numSkinSamples,3);
RGBNonSkin = zeros(numNonSkinSamples,3);
counterSkin = 1;
counterNonSkin = 1;
skipY = 10;
skipX = 10;
for nImage = 1:5
    disp(sprintf('Processing training image %d', nImage));
    [height, width, channels] = size(imgTrain{nImage});
    for y = 1 : skipY : height
        for x = 1 : skipX : width
            pix = imgTrain{nImage}(y,x,:);
            if (imgTrainMask{nImage}(y,x) == 1)
                RGBSkin(counterSkin,:) = imgTrain{nImage}(y,x,:);
                counterSkin = counterSkin + 1;
            else
                RGBNonSkin(counterNonSkin,:) = imgTrain{nImage}(y,x,:);
                counterNonSkin = counterNonSkin + 1;
            end
        end % end x
    end % end y
end % nImage
RGBSkin = RGBSkin(1:counterSkin-1,:);
RGBNonSkin = RGBNonSkin(1:counterNonSkin-1,:);

% Plot samples
figure(1); clf; set(gcf, 'Color', 'w');
scatter3(RGBSkin(:,1), RGBSkin(:,2), RGBSkin(:,3), 10, [1 0 0]); hold on;
scatter3(RGBNonSkin(:,1), RGBNonSkin(:,2), RGBNonSkin(:,3), 10, [0 0 1]); hold on;
set(gca, 'XTick', 0:32:256, 'YTick', 0:32:256, 'ZTick', 0:32:256);
set(gca, 'FontSize', 16);
xlabel('R'); ylabel('G'); zlabel('B'); axis square; axis([0 256 0 256 0 256]);

%% Perform testing

% Perform MAP classification
imgFaceDetection = cell(1,2);
for nImage = 1 : numTesting
    disp(sprintf('Processing testing image %d', nImage));
    [height, width, channels] = size(imgTrain{nImage});
    for y = 1 : height
        for x = 1 : width
            pix = imgTest{nImage}(y,x,:);
            for c = 1 : channels
                [minDist, idxRGB(c)] = min(abs(double(pix(c)) - centroids1D));
            end % end c
            if (centroidClass(idxRGB(1), idxRGB(2), idxRGB(3)) == 1)
                imgFaceDetection{nImage}(y,x) = 1;
            else
                imgFaceDetection{nImage}(y,x) = 0;
            end
        end % end x
    end % end y
end % end nImage

% Perform area filtering
mapFace1 = imgFaceDetection{1};
mapFace2 = imgFaceDetection{2};
areaFilteredFace1 = areaFilter(mapFace1, 10000000, 500);
areaFilteredFace2 = areaFilter(mapFace2, 10000000, 500);

% Show images
subplot(2,3,1), imshow(imgTest{1}), title('original');
subplot(2,3,4), imshow(imgTest{2}), title('original');
subplot(2,3,2), imshow(mapFace1), title('map detector');
subplot(2,3,5), imshow(mapFace2), title('map detector');
subplot(2,3,3), imshow(areaFilteredFace1), title('map detector + area filter');
subplot(2,3,6), imshow(areaFilteredFace2), title('map detector + area filter');

% Save images
imwrite(logical(mapFace2), 'MAP_Skin_Detector_mapFace.png');
imwrite(logical(areaFilteredFace2), 'MAP_Skin_Detector_areaFilteredFace.png');