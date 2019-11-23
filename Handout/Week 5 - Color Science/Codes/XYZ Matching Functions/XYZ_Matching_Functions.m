% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% CIE 1931 XYZ color system

% ciexyz31_1.mat: CIE 1931 color matching functions
% 2-degree, XYZ CMFs, at 1nm resolution
% Reference: http://cvrl.ioo.ucl.ac.uk/cmfs.htm

clear, clc, close all

% Load data
load('ciexyz31_1.mat', 'CMFs');
wavelength = CMFs(:, 1);
XYZ = CMFs(:, 2 : 4);

% Show XYZ color matching functions
axes('Parent', figure, 'FontSize', 15);
plot(wavelength, XYZ(:, 1), 'r',  wavelength, XYZ(:, 2), 'g', wavelength, XYZ(:, 3), 'b', 'LineWidth', 2, 'LineSmoothing','on');
legend('x({\lambda})','y({\lambda})','z({\lambda}) ', 'Location', 'Best');
xlabel('Wavelength {\lambda} (nm)');
ylabel('Tristimulus values');
title('XYZ color matching functions')
axis([300 800 0 2]);
grid on;
saveas(gcf, 'XYZ_Matching_Functions_xyzmatching.png');