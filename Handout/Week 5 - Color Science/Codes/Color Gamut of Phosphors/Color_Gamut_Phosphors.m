% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Color gamut

clear, clc, close all

% Load chromaticity data
load('IN.mat');
cd = imread('chromaDiagram.png');
% imshow(cd), hold on;
xIndex = repmat((1 : 1000), 1000, 1);
yIndex = xIndex';

% Define primary coordinates in (x,y) space
primary = [0.67, 0.33; 
          0.21, 0.71; 
          0.14, 0.08] * 1000;   
      
% Show horseshoe without primary triangle
resolution = 1000;        
GAMUT = inpolygon(xIndex, yIndex, primary(:, 1), primary(:, 2));
figure(1), clf, imshow(GAMUT, 'XData', linspace(0,1,resolution), ...
    'YData', linspace(0,1,resolution));
axis on;
set(gca, 'YDir', 'Normal');
xlabel('x'); ylabel('y');

% Show primary triangle
R = IN .* (1 - GAMUT);
figure(2), clf, imshow(R, 'XData', linspace(0,1,resolution), ...
    'YData', linspace(0,1,resolution));
axis on;
set(gca, 'YDir', 'Normal');
xlabel('x'); ylabel('y');
 
% Show primary colors in (x,y) space
idx = find(R == 1);
r = cd(:, :, 1); r(idx) = 128;
g = cd(:, :, 2); g(idx) = 128;
b = cd(:, :, 3); b(idx) = 128;
gamutCd = cat(3, r, g, b);
figure(3), clf, imshow(gamutCd, 'XData', linspace(0,1,resolution), ...
    'YData', linspace(0,1,resolution));
axis on;
set(gca, 'YDir', 'Normal');
xlabel('x'); ylabel('y');
hold on 
white = [0.31, 0.32] * 1000;
plot(white(1), white(2), 'ow');
text(white(1), white(2), ' Reference white', 'FontSize', 15);

% Save resulting image
saveas(gcf, 'Color_Gamut_Phosphors_gamut.png');