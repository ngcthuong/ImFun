import cv2
import numpy as np
import math
import matplotlib.pyplot as plt


img = cv2.imread('croppedBike.png',0)
row, col = img.shape

#Perform subsampling by matrix multiplication
a = np.eye(row//4)
img=np.array(img)
print(img.shape)
print(a.shape)
b = [1, 0, 0, 0]
c = [0.25, 0.25, 0.25, 0.25]
print(b)
H1 = np.kron(a, b)
H2 = np.kron(a, c)
subImg1 = np.dot(H1 ,img , H1)
subImg2 = np.dot(H2 , img , H2)

#Show images
# plt.subplot(1, 2, 1), plt.imshow(subImg1), plt.title('Method 1')
# plt.subplot(1, 2, 2), plt.imshow(subImg2), plt.title('Method 2')
y=['method 1','method 2']
x = [subImg1, subImg2]
for i in range(2):
    plt.subplot(1,2,i+1),plt.imshow(x[i],'gray')
    plt.title(y[i])
    plt.xticks([]),plt.yticks([])
plt.show()
# Save images
cv2.imwrite('Subsampling_subsample_1.png',subImg1)
cv2.imwrite('Subsampling_subsample_2.png',subImg2)
