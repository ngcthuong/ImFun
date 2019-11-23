% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Spectral matching functions

% colorMatchingFunction.mat: Stiles & Burch (1959) 10-deg, RGB CMFs
% Reference: http://cvrl.ioo.ucl.ac.uk/cmfs.htm

clear, clc, close all

% Load color matching functions
load('colorMatchingFunction.mat', 'CMFs');
wavelength = CMFs(:, 1);
XYZ = CMFs(:, 2 : 4);

axes('Parent', figure, 'FontSize', 15);
plot(wavelength, XYZ(:, 1), 'r',  wavelength, XYZ(:, 2), 'g', wavelength, XYZ(:, 3), 'b', 'LineWidth', 2, 'LineSmoothing','on');
legend('r({\lambda})','g({\lambda})','b({\lambda}) ', 'Location', 'Best');
xlabel('Wavelength {\lambda} (nm)');
ylabel('Tristimulus values');
title('CIE color matching functions');
axis([390 760 -0.5 3.5]);
grid on;
saveas(gcf, 'Color_Matching_Functions_rgbmatching.png');
