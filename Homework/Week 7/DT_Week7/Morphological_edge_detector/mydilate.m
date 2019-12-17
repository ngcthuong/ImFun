function imgB = mydilate(img,neighbor)
[x, y] = size(neighbor);
[ximg, yimg] = size(img);

% Shift img 
x_add = floor(x / 2);
y_add = floor(y / 2);
xsize = ximg + 2 * x_add;
ysize = yimg + 2 * y_add;
img_new = zeros(xsize, ysize);
img_new(x_add+1:x_add+ximg,y_add+1:y_add+yimg) = img;

% Dilation
imgB = img;

for i=1:ximg
    for j=1:yimg
        % Khoi tao window tai img(i,j)
        x = i:i+x_add*2;
        y = j:j+y_add*2;
        imgW = img_new(x,y);
        % OR(window)
        for i1 = 1:size(imgW,1)
            for j1 = 1:size(imgW,2)
                if (imgW(i1,j1)==1)&&(neighbor(i1,j1)==1) 
                    imgB(i,j)=1;
                    break;
                end
            end
        end
    end
end
end

