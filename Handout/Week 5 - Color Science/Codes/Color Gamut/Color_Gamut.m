% EE368/CS232 Digital Image Processing
% Bernd Girod
% Department of Electrical Engineering, Stanford University 

% Script by Qiyuan Tian and David Chen
% Color gamut and chromaticity

clear, clc, close all

cd = imread('chromaDiagram.png');
load('IN.mat');

sampleArray = [60 3 20];
scaleArray = [0.5 1 2];  
 for i = 1 : 3
    sample = sampleArray(i);
    scale = scaleArray(i);
    
    sampledCd = cd(1 : sample : end, 1 : sample : end, :);
    sampledIN = IN(1 : sample : end, 1 : sample : end);

    N = size(sampledCd, 1);

    idx = find(sampledIN == 1);

    x = ceil(idx / N);
    y = idx - N * (x-1);
    z = N - x - y;
    x = x / N;
    y = y / N;
    z = z / N;

    r = sampledCd(:, :, 1); r = r(idx);
    g = sampledCd(:, :, 2); g = g(idx);
    b = sampledCd(:, :, 3); b = b(idx);
    rgb = [r, g, b];
    rgb = double(rgb) / 255;

    x = scale * x;
    y = scale * y;
    z = scale * z;
    scatter3(x, y, z, 10, rgb, 'filled');

    hold on
end %end scale

view(52, 24)
xlabel('X'), ylabel('Y'), zlabel('Z')
grid on
axis equal
zlim([0 1.5])
% axis([0 1.5 0 1.5 0 1.5])
plot3([1;0;0; 1], [0;1;0; 0],[0;0;1;0], 'LineWidth', 2);
saveas(gca, 'Color_Gamut_chromaSolid.png');

%%
vwObj = VideoWriter('Color_Gamut', 'Motion JPEG AVI');
vwObj.FrameRate = 10;
vwObj.Quality = 95;
open(vwObj);    

angle = [52 : -1: 30, 30 : 1 : 80, 80 : -1 : 52];
for i = 1 : numel(angle)
    view(angle(i), 24);
    currFrame = getframe(1);
    writeVideo(vwObj, currFrame);
end

close(vwObj);



