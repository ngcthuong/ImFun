% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Absorption of light in the cones of the human retina

% coneFundamentals.mat: 
% 2-deg fundamentals based on the Stiles & Burch 10-deg CMFs (adjusted to 2-deg)
% Reference: http://www.cvrl.org/cones.htm

% Load cone fundamentals
clear, clc, close all
load('coneFundamentals.mat', 'coneFundamentals');
wavelength = coneFundamentals(:, 1);
LMS = coneFundamentals(:, 2 : 4);

% Plot sensitivity curves
axes('Parent', figure, 'FontSize', 15);
plot(wavelength, LMS(:, 1), 'r',  wavelength, LMS(:, 2), 'g', wavelength, LMS(:, 3), 'b', 'LineWidth', 2, 'LineSmoothing','on');
legend('L: S_{R}({\lambda})','M: S_{G}({\lambda})','S: S_{B}({\lambda}) ', 'Location', 'NorthEast');
text(445, 0.9, '445 nm', 'FontSize', 15, 'Color', 'blue');
text(535, 0.9, '535 nm', 'FontSize', 15, 'Color', 'green');
text(575, 0.95, '575 nm', 'FontSize', 15, 'Color', 'red');
xlabel('Wavelength {\lambda} (nm)');
ylabel('Normalized Sensitivity');
title('Cone Fundamentals');
axis([390 760 0 1]);
grid on;
saveas(gcf, 'Absorption_Spectra_fundamentals.png');
