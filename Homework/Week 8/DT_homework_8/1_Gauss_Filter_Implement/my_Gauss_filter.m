function imgW = my_Gauss_filter(img, Gauss_mask)
imgW = mask_kernel_with_replicate(img, Gauss_mask);
end

