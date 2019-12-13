clear, clc, close all

% Load test image

load('integral.mat', 'imgI');
[x, y] = size(imgI);
img = zeros(x-1, y-1);
windowsize = 25;
n = (windowsize - 1)/2;
for i = 1:x-1
    for j = 1:y-1
        if i<=n i1 = n+1;
        else if i>=x-n i1 = x-n-1;
            else i1 = i;  
            end
        end
        if j <=n
            j1 = n+1;
        else if j>=y-n
                j1 = y-n-1;
            else
            j1 = j;
            end
        end
        img(i,j) = imgI(i1+n+1, j1+n+1) + imgI(i1-n, j1-n) - imgI(i1-n, j1+n+1) - imgI(i1+n+1,j1-n);
    end
end
img = img / 625;
imwrite(img, 'img_use_Intergral_25.png');