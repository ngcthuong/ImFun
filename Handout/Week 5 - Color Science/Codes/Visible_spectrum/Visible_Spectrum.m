% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Color: visible range of the electromagnetic spectrum 

% visibleSpectrum.mat:  CIE 1931 color matching functions
% 2-degree, XYZ CMFs, at 1nm resolution, limit to [380nm, 760nm]
% Reference: http://cvrl.ioo.ucl.ac.uk/cmfs.htm

clear, clc, close all

% Load color matching functions
load('visibleSpectrum.mat', 'CMFs');
wavelength = CMFs(:, 1);
XYZ = CMFs(:, 2 : 4);

% Create wavelength to RGB mapping
XYZ = permute(XYZ, [3, 1, 2]);
cform = makecform('xyz2srgb');
RGB = applycform(XYZ, cform);
RGB = repmat(RGB, [50, 1, 1]);

% Show spectrum image
imshow(RGB)
title('Visible spectrum(380nm ~ 760nm)');
xlabel('Wavelength (nm)');
imwrite(RGB, 'Visible_Spectrum_colorspectrum.png');