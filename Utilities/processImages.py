import numpy as np
import cv2
from PIL import Image

def convertImageToArrayColor (numberOfExamples, imagePath):
    #Get dimensions
    firstImageName = imagePath + str(1) +'.ppm'
    img = cv2.imread(firstImageName)
    [n,d,t] = img.shape

    X = np.zeros((numberOfExamples, n, d, t))

    
    for i in range(numberOfExamples):
        imageName = imagePath + str(i+1) +'.ppm'
        img = cv2.imread(imageName)
        X[i] = np.reshape(img, (1, n, d, t))
 
    return X

def convertLabelToArray(numberOfExamples, imagePath):
    #Get dimensions
    firstImageName = imagePath + str(1) +'.ppm'
    img = cv2.imread(firstImageName)
    [n,d,t] = img.shape
    numClasses = 5
    X = np.zeros((numberOfExamples, n, d, numClasses))
    grass = 200
    road = 100
    sidewalk = 255
    dirt = 80
    bushes = 160


    
    for i in range(numberOfExamples):
        imageName = imagePath + str(i+1) +'.ppm'
        img = cv2.imread(imageName)
        for row in range(n):
            for col in range(d):
                if img[row,col,1] == grass:
                    X[i,row,col,0] = 1

                elif img[row,col,1] == road:
                    X[i,row,col,1] = 1

                elif img[row,col,1] == sidewalk:
                    X[i,row,col,2] = 1

                elif img[row,col,1] == dirt:
                    X[i,row,col,3] = 1
                    
                elif img[row,col,1] == bushes:
                    X[i,row,col,4] = 1   
    return X


def resizeImages (numberOfExamples, filePath, savePath):
    for i in range(numberOfExamples):
        currImage = filePath + str(i) +'.png'
        img = Image.open(currImage)

        resizedImage = img.resize((50,50), Image.BICUBIC)

        imageName = savePath + str(i) + ".png"
        resizedImage.save(imageName, 'PNG')

def standardizeCols(M, *args):
        stdM = np.zeros(M.shape, dtype =np.float32)
        if (len(args) > 0):
            mu =  args[0]
            std_dev = args[1]
        else:
        #if mu and sigma are omitted, compute from M
            mu = np.mean(M, axis=0)
            std_dev = np.std(M, axis=0)

        stdM = (M - mu) / std_dev

        return stdM, mu, std_dev

if __name__ == "__main__":
   #test run
    # y = convertLabelToArray(1, 4, 'trainingData/trainingLabelXY.txt')
    # X = convertImageToArrayColor(1, "trainingData/resizedImages/image")
    # X = convertImageToArrayColor (1, "labeledImages/image")
    X = convertLabelToArray(10, "labeledImages/image")
    print X.shape


