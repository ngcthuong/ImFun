function imgW = my_Wiener_filter(img, var_noise)
[x, y] = size(img);
imgW = img;
for i =1:x
    for j = 1:y
        window = img(max(i-1,1):min(i+1,x),max(j-1,1):min(j+1,y));
        u = mean(window(:));
        variance = var(window(:));
        if variance ~=0
            imgW(i,j) = u + (variance - var_noise) / variance * (img(i,j) - u);
        end
    end
end
end

