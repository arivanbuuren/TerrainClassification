import cv2
import numpy as np

IM_WIDTH = 160
IM_HEIGHT = 120

grass = [0, 200, 0]
road = [100, 100, 100]
sidewalk = [0, 255, 255]
dirt = [45,80,160]
bushes = [32,160,220]


imageName = 'segmentedImage/image15.ppm'
saveName = 'cleanSegments/image15.ppm'

img = cv2.imread(imageName)
img2 = img

segments = np.unique(img[:,:,0], return_counts = True)
indicesA = np.where(img[:,:,0] == 81) 
indicesB = np.where(img[:,:,0] == 20) 
indicesC = np.where(img[:,:,0] == 3)
indicesD = np.where(img[:,:,0] == 6)
indicesE = np.where(img[:,:,0] == 54)
indicesF = np.where(img[:,:,0] == 129)
indicesG = np.where(img[:,:,0] == 163)
indicesH = np.where(img[:,:,0] == 173)
indicesI = np.where(img[:,:,0] == 219)
indicesJ = np.where(img[:,:,0] == 250)
   
for i in range(len(indicesA[0])):
    img2[indicesA[0][i], indicesA[1][i], :] = road
    
    
for i in range(len(indicesB[0])):
    img2[indicesB[0][i], indicesB[1][i], :] = bushes
for i in range(len(indicesC[0])):
    img2[indicesC[0][i], indicesC[1][i], :] = road
    
for i in range(len(indicesD[0])):
    img2[indicesD[0][i], indicesD[1][i], :] = road
    
for i in range(len(indicesE[0])):
    img2[indicesE[0][i], indicesE[1][i], :] = road

for i in range(len(indicesF[0])):
    img2[indicesF[0][i], indicesF[1][i], :] = road

for i in range(len(indicesG[0])):
    img2[indicesG[0][i], indicesG[1][i], :] = dirt

for i in range(len(indicesH[0])):
    img2[indicesH[0][i], indicesH[1][i], :] = road

for i in range(len(indicesI[0])):
    img2[indicesI[0][i], indicesI[1][i], :] = road
    
for i in range(len(indicesJ[0])):
    img2[indicesJ[0][i], indicesJ[1][i], :] = road

cv2.imshow("segmented", img2)


cv2.imwrite(saveName, img2)
