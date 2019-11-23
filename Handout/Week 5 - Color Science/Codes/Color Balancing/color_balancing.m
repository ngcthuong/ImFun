function [rgb_balanced, k] = color_balancing(rgb, method, upper_limit, target_gray_mean)
% -Input-
% rgb: double[height x width x 3], the input RGB image,
% method: char[]
% 1. 'gray-world'
% 2. 'scale-by-max'
% 3. 'shades-of-gray'
% 4. 'gray-edge'
% 5. 'max-edge'
% upper_limit: double[3x1], maximum allowable RGB values
%
% -Output-
% rgb_balanced: double[height x width x 3], the output balanced image
% k: double[3x1], scaling factor for R, G, B components

% Find scaling factor
[rows, cols, channels] = size(rgb);
switch lower(method)
    case 'gray-world'
        mean_rgb = mean(mean(rgb,2),1);
        k = mean_rgb(2)./mean_rgb(:);

    case 'scale-by-max'
        max_rgb = max(max(rgb,[],2),[],1);
        k = upper_limit(:)./max_rgb(:);
        
    case 'shades-of-gray'
        p = 6;
        mpnorm = zeros(1,3);
        for i = 1:3
            pix = rgb(:,:,i);
            mpnorm(i) = sum(pix(:).^p)^(1/p);
        end % i
        k = mpnorm(2)./mpnorm;
        
    case 'gray-edge'
        p = 1;
        mpnorm = zeros(1,3);
        rgb_grad = gradient_magnitude(rgb);
        for i = 1:3
            pix_grad = rgb_grad(:,:,i);
            mpnorm(i) = sum(pix_grad(:).^p)^(1/p);
        end % i
        k = mpnorm(2)./mpnorm;
        
    case 'max-edge'
        mpnorm = zeros(1,3);
        rgb_grad = gradient_magnitude(rgb);
        for i = 1:3
            pix_grad = rgb_grad(:,:,i);
            mpnorm(i) = max(pix_grad(:));
        end % i
        k = mpnorm(2)./mpnorm;

    otherwise
        fprintf(1,'method %d is not supported.\n',method);
        rgb_balanced = [];
        return;
end

% Apply scaling factor
rgb_balanced = zeros(size(rgb));
for c = 1:3
    temp = rgb(:,:,c).*k(c);
    temp(find(temp>upper_limit(c))) = upper_limit(c);
    rgb_balanced(:,:,c) = temp;
end

% Find brightness scale factor
imgGray = rgb2gray(rgb_balanced);
imgGrayMean = mean2(imgGray);
grayK = target_gray_mean / imgGrayMean;

% Apply brightness scale factor
for c = 1:3
    temp = rgb_balanced(:,:,c).*grayK;
    temp(find(temp>upper_limit(c))) = upper_limit(c);
    rgb_balanced(:,:,c) = temp;
end