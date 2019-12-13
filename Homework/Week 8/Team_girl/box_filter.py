import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import math
import sys
import cv2
import scipy.ndimage
sigma = 1
x = np.linspace(-4*sigma,4*sigma,501)
g1 = np.exp(-x**2 / (2*sigma**2)) / math.sqrt(2*math.pi*(sigma**2))
N = 5
w = math.sqrt(12 * sigma**2 / N)
b = (abs(x) < w/2) * 1/w
g2 = b
for n in range (2,N+1):
    g2 = np.convolve(g2, b, 'same')
y=['g1', 'b', 'g2']
x = [g1,b,g2 ]
#print(g1)
for i in range(3):
    plt.subplot(1,3,i+1)
    plt.title(y[i])
    plt.xticks([]),plt.yticks([])
plt.show()
#% Load test image
img = cv2.imread('noise_image_50.jpg',0)
#img = rgb2gray(img);
cv2.imwrite('gray_noise_50.jpg',img)

#% Filter by Gaussian
def fspecial(shape=(3,3),sigma=0.5):
    m,n = [(ss-1.)/2. for ss in shape]
    y,x = np.ogrid[-m:m+1,-n:n+1]
    h = np.exp( -(x*x + y*y) / (2.*sigma*sigma) )
    h[ h < np.finfo(h.dtype).eps*h.max() ] = 0
    sumh = h.sum()
    if sumh != 0:
        h /= sumh
    return h
sigma = 25
g = fspecial((25, 25), sigma)
img_g= scipy.ndimage.convolve(img, g, mode='nearest')
#plt.figuge
plt.imshow(img_g,'gray')
plt.title('Filtered by Gaussian')
cv2.imwrite('img_g_50.jpg',img_g)
plt.show()
#sys.exit()
#% Filter by box
[X,Y] = np.mgrid[-5*sigma:5*sigma, -5*sigma:5*sigma]
N = 5
w = math.sqrt(12 * sigma**2 / N)
b = (abs(X) < w/2) * (abs(Y) < w/2)
b = b/np.sum(b)
img_b = img
x=img_g - img_b
print(x)
for n in range(1,N+1):
    #disp(n)
    fig = plt.subplot(2,3, n+1)
    img_b = scipy.ndimage.convolve(img_b, b,mode='nearest')
    plt.imshow(img_b,'gray')
    if n == 1:
        plt.title('Filtered by '+str(n)+' Box')
    else:
        plt.title('Filtered by '+str(n)+ ' Boxes')
    cv2.imwrite('img_b_25_'+str(n)+'.jpg', img_b)
    #cv2.imwrite('cp'+ str(n)+'.jpg',abs(img_b-img_g))
plt.show()
