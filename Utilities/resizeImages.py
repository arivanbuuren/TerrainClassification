import cv2
import numpy as np

IM_WIDTH = 160
IM_HEIGHT = 120


def resizeImage(start, end, imagePath, savePath):
    for imNumber in range(start, end):
        imageName = imagePath + str(imNumber) + '.JPG'
        img = cv2.imread(imageName)
        img2 = cv2.resize(img, (IM_WIDTH, IM_HEIGHT), interpolation = cv2.INTER_AREA)
        saveName = savePath + '/image' + str(imNumber) + '.png'
        cv2.imwrite(saveName, img2)
        print imNumber
        
if __name__ == "__main__":   
    resizeImage(84, 85, "crops/image", "resizedCrops")