import cv2
import numpy as np
##project
IM_WIDTH = 160
IM_HEIGHT = 120

unassigned = [255, 255, 255]
grass = [0, 200, 0]
road = [100, 100, 100]
sidewalk = [0, 255, 255]
dirt = [45,80,160]
bushes = [32,160,220]
obstacle = [0, 0, 0] 


imgNumber = 59
imageName = 'clusters/image'+ str(imgNumber)+ '.ppm'
saveName = 'cleanSegments/image'+ str(imgNumber)+ '.ppm'

currClass = 1
myClasses = {'unassigned':0, 'grass':1, 'road':2, 'sidewalk':3, 'dirt':4, 'bushes':5, 'obstacle':6}
myClassesList = [unassigned, grass, road, sidewalk, dirt, bushes, obstacle]

def onMouseClick(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONUP:
        assign_class(x,y, param)

def assign_class(x,y, image):
    strClass = (list(myClasses.keys())[list(myClasses.values()).index(currClass)])
    
    print "You are currently assigning: ", strClass
    clusterColor =  image[y,x,:]
    clusterIndices = np.where(image[:,:,:] == clusterColor)

    for i in range(len(clusterIndices[0])):
        image[clusterIndices[0][i], clusterIndices[1][i], :] = myClassesList[currClass]
       
    cv2.imwrite(imageName, image)


image = cv2.imread(imageName)
cv2.namedWindow("clusters")
cv2.setMouseCallback("clusters", onMouseClick, param = image)

while True:
    cv2.imshow("clusters", image)
    key = cv2.waitKey(1) & 0xFF

    if key == ord("c"):
        break
    elif key == ord("1"):
        print "Changed to Grass"
        currClass = 1
    elif key == ord("2"):
        print "Changed to Road"
        currClass = 2
    elif key == ord("3"):
        print "Changed to Sidewalk"
        currClass = 3
    elif key == ord("4"):
        print "Changed to Dirt"
        currClass = 4
    elif key == ord("5"):
        print "Changed to Bushes"
        currClass = 5
    elif key == ord("6"):
        print "Changed to Obstacle"
        currClass = 6
        
cv2.destroyAllWindows()

