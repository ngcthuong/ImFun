function imgK = mask_kernel_with_replicate(img,kernel)
[x, y] = size(kernel);
[ximg, yimg] = size(img);

% Shift img 
x_add = floor(x / 2);
y_add = floor(y / 2);
xsize = ximg + 2 * x_add;
ysize = yimg + 2 * y_add;
img_new = zeros(xsize, ysize);
% replicate 
img_new(x_add+1:x_add+ximg,y_add+1:y_add+yimg) = img;
for i = 1:x_add
    img_new(i,:) = img_new(x_add+1,:);
end
for i = xsize-x_add:xsize
    img_new(i,:) = img_new(x_add+ximg,:);
end
for i = 1:y_add
    img_new(:,i) = img_new(:,y_add+1);
end
for i = ysize-y_add:ysize
    img_new(:,i) = img_new(:,y_add+yimg);
end
% Dilation
imgK = img;
for i=1:ximg
    for j=1:yimg
        % Khoi tao window tai img(i,j)
        x = i:i+x_add*2;
        y = j:j+y_add*2;
        imgW = img_new(x,y);
        % OR(window)
        imgW1 = imgW .* kernel;
        imgK(i,j) = sum(imgW1(:));
    end
end
end


