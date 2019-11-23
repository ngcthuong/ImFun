% demo
% This is function to draw circle for illustration 
img_size = 512; 
curVal   = 200; 

bigCircleImage = zeros(img_size, img_size);
[x, y] = meshgrid(1:img_size, 1:img_size);

radius = [250 190 140 100 50];
ratio  = ([0.5 1 2 4 8] / 100) + 1;
for i = 1:1:length(radius)
    rad = radius(i); 
    curVal = curVal * ratio(i);
    bigCircleImage((x - img_size/2).^2 + (y - img_size/2).^2 <= rad.^2) = curVal;
end

imshow(uint8(bigCircleImage));
%title('Big Circle Mask', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
