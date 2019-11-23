% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Perceptual non-uniformity of xy chromaticity

% Reference:
% http://en.wikipedia.org/wiki/File:CIExy1931_MacAdam.png

clear, clc, close all

% Load MacAdam ellipse data
data = [
0.160 0.057 0.85 0.35  62.5
0.187 0.118 2.20 0.55  77.0
0.253 0.125 2.50 0.50  55.5
0.150 0.680 9.60 2.30 105.0
0.131 0.521 4.70 2.00 112.5
0.212 0.550 5.80 2.30 100.0
0.258 0.450 5.00 2.00  92.0
0.152 0.365 3.80 1.90 110.0
0.280 0.385 4.00 1.50  75.5
0.380 0.498 4.40 1.20  70.0
0.160 0.200 2.10 0.95 104.0
0.228 0.250 3.10 0.90  72.0
0.305 0.323 2.30 0.90  58.0
0.385 0.393 3.80 1.60  65.5
0.472 0.399 3.20 1.40  51.0
0.527 0.350 2.60 1.30  20.0
0.475 0.300 2.90 1.10  28.5
0.510 0.236 2.40 1.20  29.5
0.596 0.283 2.60 1.30  13.0
0.344 0.284 2.30 0.90  60.0
0.390 0.237 2.50 1.00  47.0
0.441 0.198 2.80 0.95  34.5
0.278 0.223 2.40 0.55  57.5
0.300 0.163 2.90 0.60  54.0
0.365 0.153 3.60 0.95  40.0];

% Load chromaticity diagram
cd = imread('chromaDiagram.png');
imshow(cd), hold on;

% Plot ellipse borders
x = data(:, 1) * 1000;
y = data(:, 2) * 1000;
a = data(:, 3) *10;
b = data(:, 4) *10;
t = data(:, 5) / 180 * pi; 
f = 0 : 0.0001 : 2*pi;
for i = 1 : size(data, 1);
     aa=a(i) * cos(f);
     bb=b(i) * sin(f);
     xx=x(i) + aa*cos(t(i))-bb*sin(t(i));
     yy=y(i)+aa*sin(t(i))+bb*cos(t(i));
     plot(xx, yy, 'k', 'LineWidth', 1, 'LineSmoothing', 'on');
     plot(xx+2, yy+2, 'w', 'LineWidth', 1, 'LineSmoothing', 'on');
     hold on
end

% Plot ellipse centers
plot(x, y, 'k.', 'LineWidth', 1, 'LineSmoothing', 'on')
plot(x+2, y+2, 'w.', 'LineWidth', 1, 'LineSmoothing', 'on')
set(gca, 'YDir', 'Normal');
saveas(gca, 'Perceptual_Nonuniformity_non-uniformity.png');









