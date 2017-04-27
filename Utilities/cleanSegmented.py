import cv2
import numpy as np
##Global variables ###
IM_WIDTH = 160
IM_HEIGHT = 120

unassigned = [255, 255, 255]
grass = [0, 200, 0]
road = [100, 100, 100]
sidewalk = [0, 255, 255]
dirt = [45,80,160]
bushes = [32,160,220]
tree = [0, 0, 0] 
post = [153, 77, 0]

imgNumber = 60
imageName = 'clusters/image'+ str(imgNumber)+ '.ppm'
saveName = 'clusters/backup/image.ppm'

currClass = 1
myClasses = {'unassigned':0, 'grass':1, 'road':2, 'sidewalk':3, 'dirt':4, 'bushes':5, 'tree':6, 'post':7}
myClassesList = [unassigned, grass, road, sidewalk, dirt, bushes, tree, post]
image = cv2.imread(imageName)


def onMouseClick(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONUP:
        assign_class(x,y, param)

def assign_class(x,y, img):
    #Save backup image before changes
    cv2.imwrite(saveName, img)

    strClass = (list(myClasses.keys())[list(myClasses.values()).index(currClass)])
    
    print "You are currently assigning: ", strClass
    #Obtain color of clicked pixel and find all pixels with the same value
    clusterColor =  img[y,x,:]
    clusterIndices = np.where(img[:,:,:] == clusterColor)
    
    #Update color of cluster
    for i in range(len(clusterIndices[0])):
        img[clusterIndices[0][i], clusterIndices[1][i], :] = myClassesList[currClass]
    
    #Save modified image
    cv2.imwrite(imageName, img)

###### Main program starts here ######

cv2.namedWindow("clusters")
cv2.setMouseCallback("clusters", onMouseClick, param = image)

while True:
    cv2.imshow("clusters", image)
    key = cv2.waitKey(1) & 0xFF

    if key == ord("c"):
        break
    elif key == ord("z"):
        print "Going back 1 step"
        backup = cv2.imread(saveName)
        cv2.imwrite(imageName, backup)
        image = cv2.imread(imageName)
        cv2.imshow("clusters", image)
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
        print "Changed to Tree"
        currClass = 6
    elif key == ord("7"):
        print "Changed to Post" 
        currClass = 7
        
cv2.destroyAllWindows()

