% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% White at different color temperatures

clear, clc, close all

% Load data
load('ciexyz31_1.mat');
cd = imread('chromaDiagram.png');
imshow(cd), hold on;

% Define constants
h = 6.62606957 * 1e-34;	 % The Planck constant: J¡¤s
c = 299792458; % The speed of light: m/s
kB = 1.3806488 * 1e-23; % The Boltzmann constant: J/K
wavelength = CMFs(:, 1) * 1e-9; % Wavelength: m
T = 1 : 30000; % The absolute temperature of the black body: K
bLambdaT = zeros(numel(T), numel(wavelength));

% Calculate spectra for different temperatures
for i = 1 : numel(T)
    bLambdaT(i, :) = 2 * h * c^2 ./ (  wavelength.^5 .*(exp(h * c ./ (wavelength * kB * T(i) )) - 1)  );
end

% Get XYZ coordinates and xy coordinates
xMatch = repmat(CMFs(:, 2)', [numel(T), 1]);
yMatch = repmat(CMFs(:, 3)', [numel(T), 1]);
zMatch = repmat(CMFs(:, 4)', [numel(T), 1]);
X = sum(bLambdaT .* xMatch, 2);
Y = sum(bLambdaT .* yMatch, 2);
Z = sum(bLambdaT .* zMatch, 2);
x = X ./ (X+Y+Z) * 1000;
y = Y ./ (X+Y+Z) * 1000;

% Show and save results
plot(x, y, '.w');
set(gca, 'YDir', 'Normal');
sample = [1000, 2000, 3000, 4000, 6000, 10000, 30000];
plot(x(sample), y(sample), '.r');
for n = 1:numel(sample)
    T = sample(n);
    for dx = -2:2
        for dy = -2:2
            h = text(x(T)+5+dx, y(T)-18+dy, [num2str(T) 'K']);
            set(h, 'Color', 'k');
        end % dy
    end % dx
    h = text(x(T)+5, y(T)-18, [num2str(T) 'K']);
    set(h, 'Color', 'w');
end % n
saveas(gca, 'Different_Temperatures_planckLocus.png');