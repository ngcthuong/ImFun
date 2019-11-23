% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% CIE chromaticity diagram

clear, clc, close all

%% Detect points inside the diagram
load('ciexyz31_1.mat', 'CMFs');
X = CMFs(:, 2); Y = CMFs(:, 3); Z = CMFs(:, 4);

x = X ./ (X+Y+Z);
y = Y ./ (X+Y+Z);
z = Z ./ (X+Y+Z);

resolution = 1000;
x = resolution * x; 
y = resolution * y;
z = resolution * z;
    
xIndex = repmat((1 : resolution), resolution, 1);
yIndex = xIndex';

% IN = inpolygon(xIndex, yIndex, x, y);
load('IN.mat');
figure(1), clf, imshow(IN, 'XData', linspace(0,1,resolution), ...
    'YData', linspace(0,1,resolution));
axis on;
set(gca, 'YDir', 'Normal');
xlabel('x'); ylabel('y');
title('Visible Region');

xImg = xIndex .* IN / resolution;
yImg = yIndex .* IN / resolution;
zImg = (resolution - xIndex - yIndex) .* IN / resolution;
xyzImg = cat(3, xImg, yImg, zImg);

%% Convert from xyz to RGB
% Reference: http://www.brucelindbloom.com/index.html?ChromaticityGamuts.html
sigma = 0.0001;

xr = 0.735; yr = 0.265;
xg = sigma; yg = 1;
xb = sigma; yb = -0.074;

Xr = xr / yr;
Yr = 1;
Zr = (1 - xr - yr) / yr;

Xg = xg / yg;
Yg = 1;
Zg = (1 - xg - yg) / yg;

Xb = xb / yb;
Yb = 1;
Zb = (1 - xb - yb) / yb;

white = whitepoint('D65')';
m = [Xr, Xg, Xb;
         Yr, Yg, Yb;
         Zr, Zg, Zb];
S = inv(m) * white; 
Sr = S(1); Sg = S(2); Sb = S(3);

M_rgb2xyz = [Sr * Xr, Sg * Xg, Sb * Xb;
        Sr * Yr, Sg * Yg, Sb * Yb;
        Sr * Zr, Sg * Zg, Sb * Zb];
    
M_xyz2rgb = inv(M_rgb2xyz);
rgbImg = colorSpaceTransform(xyzImg, M_xyz2rgb);
figure(2), clf;
imshow(rgbImg, 'XData', linspace(0,1,resolution), ...
    'YData', linspace(0,1,resolution));
axis on;
set(gca, 'YDir', 'Normal');
xlabel('x'); ylabel('y');
title('Chromaticity Diagram');

imwrite(rgbImg, 'Chromaticity_Diagram_chromaDiagram.png');


