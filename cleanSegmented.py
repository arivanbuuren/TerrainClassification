import cv2
import numpy as np
##project
IM_WIDTH = 160
IM_HEIGHT = 120

grass = [0, 200, 0]
road = [100, 100, 100]

sidewalk = [0, 255, 255]
dirt = [45,80,160]
bushes = [32,160,220]
rd = road 
bs = bushes
sdw = sidewalk
drt = dirt

imgNumber = 2
imageName = 'segmentedImage/image'+ str(imgNumber)+ '.ppm'
saveName = 'cleanSegments/image'+ str(imgNumber)+ '.ppm'

img = cv2.imread(imageName)
img2 = img

segments = np.unique(img[:,:,0], return_counts = True)
indicesA = np.where(img[:,:,0] == 2);A = sdw
indicesB = np.where(img[:,:,0] == 14);B = grass
indicesC = np.where(img[:,:,0] == 55);  C = rd
indicesD = np.where(img[:,:,0] == 77); D = grass
indicesE = np.where(img[:,:,0] == 135); E = rd
indicesF = np.where(img[:,:,0] == 151);F = rd
indicesG = np.where(img[:,:,0] == 206);G = rd
indicesH = np.where(img[:,:,0] == 248);H = drt
indicesI = np.where(img[:,:,0] == 249);I = grass
indicesJ = np.where(img[:,:,0] == 252);J = bs
indicesK = np.where(img[:,:,0] == 75);K = bs
   
for i in range(len(indicesA[0])):
    img2[indicesA[0][i], indicesA[1][i], :] = A
    
    
for i in range(len(indicesB[0])):
    img2[indicesB[0][i], indicesB[1][i], :] = B
    
for i in range(len(indicesC[0])):
    img2[indicesC[0][i], indicesC[1][i], :] = C
    
for i in range(len(indicesD[0])):
    img2[indicesD[0][i], indicesD[1][i], :] = D
    
for i in range(len(indicesE[0])):
    img2[indicesE[0][i], indicesE[1][i], :] = E

for i in range(len(indicesF[0])):
    img2[indicesF[0][i], indicesF[1][i], :] = F

for i in range(len(indicesG[0])):
    img2[indicesG[0][i], indicesG[1][i], :] = G

for i in range(len(indicesH[0])):
    img2[indicesH[0][i], indicesH[1][i], :] = H
for i in range(len(indicesI[0])):
    img2[indicesI[0][i], indicesI[1][i], :] = I
    
for i in range(len(indicesJ[0])):
    img2[indicesJ[0][i], indicesJ[1][i], :] = J
    
for i in range(len(indicesK[0])):
    img2[indicesK[0][i], indicesK[1][i], :] = K

cv2.imshow("segmented", img2)


cv2.imwrite(saveName, img2)
