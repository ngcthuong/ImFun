function G = my_Gauss_mask(sigma)
G = double(zeros(4*sigma+1));
for i = 1:size(G,1)
    for j = 1:size(G,2)
        k = i-1-(size(G,1)-1)/2;
        l = j-1-(size(G,2)-1)/2;
        G(i,j) = 1 / (2*pi*sigma^2) * exp(-(k^2 + l^2)/(2*sigma^2));
    end
end
G = G / sum(G(:));
end
