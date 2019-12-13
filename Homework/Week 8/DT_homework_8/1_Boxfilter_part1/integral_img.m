function itgImg = integral_img(img)
[x, y] = size(img);
itgImg = zeros(x+1, y+1);
for i = 2:x+1
    for j = 2:y+1
        window = img(1:i-1, 1:j-1);
        itgImg (i,j) = sum(sum(window));
    end
end
end

