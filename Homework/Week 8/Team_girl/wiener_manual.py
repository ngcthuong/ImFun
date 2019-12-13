import numpy as np
import cv2
from matplotlib import pyplot as plt
ima = cv2.imread('croppedBike.png')
image = cv2.cvtColor(ima,cv2.COLOR_BGR2GRAY)
# adaptive wiener filter mean-squared method
# 8 neighborhood

height = image.shape[0]
width = image.shape[1]
def parameters(i_y,i_x,image_wnr):
    x = np.array((-1,0,1,-1,0,1,-1,0,1))
    y =np.array((-1,-1,-1,0,0,0,1,1,1))
    mean = 0
    variance =0
    count =0
    for k in range(9):
        if i_y+ y[k]>=0 and i_y+y[k]<height and i_x+x[k] >=0 and i_x+x[k]<width:
            count +=1
            mean += image_wnr[i_y+y[k],i_x+x[k]]
    mean = mean/count
    for k in range(9):
        if i_y+ y[k]>=0 and i_y+y[k]<height and i_x+x[k] >=0 and i_x+x[k]<width:
            variance += np.power((image_wnr[i_y+y[k],i_x+x[k]]-mean),2)
    variance = variance/count
    return  mean,variance
N_x = 30*np.random.randn(height,width)
noisy_image =image + N_x
s = 1 #s is the noise variance
filter_image = np.zeros((height,width))
for y in range(height):
    for x in range(width):
        mean,delta = parameters(y,x,noisy_image)
        if delta != 0:
            va = ((np.power(delta,2) -np.power(s,2))/np.power(delta,2))
            filter_image[y,x] = mean + va*(noisy_image[y,x]-mean)
        if delta ==0:
            filter_image[y,x] = mean

anh = [image, noisy_image,filter_image]
ten = ['origin', ' noise image', 'wiener_image']
for i in range(3):
    plt.subplot(1,3,i+1),plt.imshow(anh[i],'gray')
    plt.title(ten[i])
    plt.xticks([]),plt.yticks([])
plt.show()

