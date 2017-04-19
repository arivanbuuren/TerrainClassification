import cv2
import numpy as np

IM_WIDTH = 160
IM_HEIGHT = 120



def resizeImage(numberOfExamples, imagePath, savePath):
    for i in range(numberOfExamples):
        imageName = imagePath + str(i+1) + '.JPG'
        img = cv2.imread(imageName)
        img2 = cv2.resize(img, (IM_WIDTH, IM_HEIGHT), interpolation = cv2.INTER_AREA)
        saveName = savePath + '/image' + str(i+1) + '.ppm'
        cv2.imwrite(saveName, img2)
        print i
        
if __name__ == "__main__":   
    resizeImage(57, "trainingImages/image", "resizedImages")