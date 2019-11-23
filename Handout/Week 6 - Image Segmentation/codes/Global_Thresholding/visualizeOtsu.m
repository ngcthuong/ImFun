clear all; clf;

%v = VideoWriter('otsu_animation.avi', 'Uncompressed AVI'); open(v);
v = VideoWriter('otsu_animation.avi'); open(v);

% load image 
I = (imread('paper.png'));

% get histogram
hist = imhist(I);

% get total number of pixels
N = sum(hist);

% show original image
subplot(2,2,1);
imshow(I);
title('Original Grayscale Image');

% keep track of max between-class variance and corresponding T
sigmasq_b_max   = 0;
sigmasq_b_max_T = 0;

% keep track of all sigma_sq values
sigmasq_b_all = zeros([256 1]);

% iterate over all thresholds
for T=1:256
    
    % binarize image with current threshold
    II = zeros(size(I));
    II(I>T) = 1;
    
    % draw binarized image
    subplot(2,2,2);
    imshow(II);
    title(['Thresholded Image with T=' num2str(T)]);

    % draw histogram
    subplot(2,2,3);
    bar(hist);
    xlim([0 255]);
    title('Histogram of Original Image');
    xlabel('gray level');
    ylabel('pixel count');
    
    % red line for current threshold
    line([T T], [0 max(hist(:))], 'color', [1 0 0]);
   
    % get weights of background and foreground
    w_bg = sum(hist(1:T)) ./ N;
    w_fg = sum(hist(T+1:end)) ./ N;
    
    % get mean of background
    mu_bg = sum( (0:T-1)'.*hist(1:T)./N  ) ./ w_bg;
        
    % get mean of foreground
    mu_fg = sum( (T:255)'.*hist(T+1:end)./N  ) ./ w_fg;
        
    % compute between-class variance
    sigmasq_b_all(T) = w_bg*w_fg * (mu_fg-mu_bg)^2;
    
    % check if the current between class variance is larger than the
    % current max
    if sigmasq_b_all(T)>sigmasq_b_max
        sigmasq_b_max = sigmasq_b_all(T);
        sigmasq_b_max_T = T;
    end
    
    % draw all sigma_sq
    subplot(2,2,4);
    plot(sigmasq_b_all);
    xlabel('Threshold T');
    ylabel('\sigma_b^2');
    xlim([0 255]);
    title('Between-class Variance');
    
    drawnow;
    
    writeVideo(v,getframe(gcf));
end

% plot a marker for the max variance
hold on;
plot(sigmasq_b_max_T,sigmasq_b_all(sigmasq_b_max_T), 'x', 'color', [1 0 0]);
line([sigmasq_b_max_T sigmasq_b_max_T], [0 sigmasq_b_all(sigmasq_b_max_T)], 'color', [1 0 0]);
hold off;

subplot(2,2,3);
line([sigmasq_b_max_T sigmasq_b_max_T], [0 max(hist(:))], 'color', [1 0 0]);

% binarize image with current threshold
II = zeros(size(I));
II(I>sigmasq_b_max_T) = 1;

% draw binarized image
subplot(2,2,2);
imshow(II);
title(['Thresholded Image with T=' num2str(sigmasq_b_max_T)]);

writeVideo(v,getframe(gcf));
close(v);

% works
%TT = graythresh(I)*255