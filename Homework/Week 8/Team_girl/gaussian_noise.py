import numpy as np
import cv2
from matplotlib import pyplot as plt
import sys
ima = cv2.imread('01.jpg')
image = cv2.cvtColor(ima,cv2.COLOR_BGR2GRAY)
#add Gaussian noise
height = image.shape[0]
width = image.shape[1]
N_x = 50*np.random.randn(height,width)
print(N_x)
noisy_image = image+N_x
#cv2.imread(noisy_image)
cv2.imwrite('noise_image_50.jpg',noisy_image)
sys.exit()
#gaussian filter
#kernel is 7x7
gaussian_kernel = np.array(((1,1,2,2,2,1,1),(1,2,2,4,2,2,1),(2,2,4,8,4,2,2),(2,4,8,16,8,4,2),(2,2,4,8,4,2,2),(1,2,2,4,2,2,1),(1,1,2,2,2,1,1)))
#gaussian_kernel
n_sum = np.sum(gaussian_kernel)
n_x = gaussian_kernel.shape[0]
n_y =gaussian_kernel.shape[1]
filter_image = np.zeros((height,width))
for y in range(height):
    for x in range(width):
        for k_y in range(-n_x//2,n_x//2-1):
            for k_x in range(-n_y//2,n_y//2-1):
                pixel = 0
                p_x = x - k_x
                p_y = y - k_y
                weight_pixel_sum =0
                if p_x >=0 and p_x < width and p_y >=0 and p_y < height:
                    kernel = gaussian_kernel[k_y + n_y//2,k_x+n_x//2]
                    pixel = image[p_y,p_x]
                    weight_pixel_sum += pixel*kernel
        filter_image[y,x] = weight_pixel_sum/n_sum
img_gauss = cv2.GaussianBlur(image,ksize=(7,7),sigmaX=0.5)
anh = [image, noisy_image,filter_image,img_gauss]
ten = ['origin', ' noise image', 'gauss_image', 'cv2 gauss']
for i in range(4):
    plt.subplot(2,2,i+1),plt.imshow(anh[i],'gray')
    plt.title(ten[i])
    plt.xticks([]),plt.yticks([])
plt.show()





