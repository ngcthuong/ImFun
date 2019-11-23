% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Blackbody radiation

clear, clc, close all

h = 6.62606957 * 1e-34;	 % The Planck constant: J¡¤s
c = 299792458; % The speed of light: m/s
kB = 1.3806488 * 1e-23; % The Boltzmann constant: J/K
wavelength = (1 : 0.05 : 15) * 1e-7;
T = [4000, 5770, 7000]; % The absolute temperature of the black body: K
bLambdaT = zeros(numel(T), numel(wavelength));
for i = 1 : numel(T)
    bLambdaT(i, :) = 2 * h * c^2 ./ (  wavelength.^5 .*(exp(h * c ./ (wavelength * kB * T(i) )) - 1)  );
end

axes('Parent', figure, 'FontSize', 15); 
h = plot(wavelength*1e9, bLambdaT, '.-', 'LineWidth', 2, 'LineSmoothing', 'on');
% legend('4000 K','5770 K','7000K', 'Location', 'Best');
% xlabel('Wavelength {\lambda} ({\mu}m)');
% ylabel('B_{\lambda}(T) (W \cdot m^{-2} \cdot sr^{-1} \cdot Hz^{-1})');
% title('Planck''s Law curves');
set(h(1), 'Color', 'r');
set(h(3), 'Color', 'b');
grid on;
set(gcf, 'Color', 'white');

for i = 1 : numel(T)
    [peak, index] = max(bLambdaT(i, :));
%     text(wavelength(index)*1e6, peak, [num2str(wavelength(index) * 1e6)  '{\mu}m'], 'FontSize', 15);
end

% saveas(gcf, 'Blackbody_Radiation_planckCurve.png');



