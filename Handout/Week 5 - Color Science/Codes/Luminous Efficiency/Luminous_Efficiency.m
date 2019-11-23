% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Luminosity function

% luminosityFunction.mat: CIE photopic luminosity function modified by Judd (1951)
% Reference: http://www.cvrl.org/lumindex.htm

clear, clc, close all
load('luminosityFunction.mat', 'luminosityFunction');
wavelength = interp( luminosityFunction(:, 1), 5);
vLambda = interp( luminosityFunction(:, 2), 5);

axes('Parent', figure, 'FontSize', 15);
plot(wavelength, vLambda, 'LineWidth', 2, 'LineSmoothing','on');
text(600, 0.9, 'Peak 555nm', 'FontSize', 15);
xlabel('Wavelength {\lambda} (nm)');
ylabel('Efficiency');
title('Luminosity function');
axis([300 800 0 1.1]);
grid on;
saveas(gcf, 'Luminous_Efficiency_luminosity.png');
