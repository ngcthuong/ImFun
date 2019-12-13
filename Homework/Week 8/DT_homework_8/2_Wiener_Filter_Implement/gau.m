img=im2double(imread ('02.jpg'));
img=rgb2gray(img);
%imshow(img); 
sw=45;
K=zeros(sw,sw);
sigma=10;
W=0;
for i=1:sw
    for j=1:sw
        s=(i-ceil(sw/2)).^2+(j-ceil(sw/2)).^2;
        K(i,j)=exp(-1*(s)/(2*(sigma.^2)));
        W=W+K(i,j);
    end
end
K=K/W;
[m,n]=size(img);
out=zeros(m,n);
I=padarray(img,[floor(sw/2),floor(sw/2)]);
for i=1:(m)
    for j=1:(n)
        t=I(i:i+sw-1,j:j+sw-1);
        t=double(t);
        con=t.*K;
        out(i,j)=sum(con(:));
    end
end
imwrite(out,'02result50.jpg');
