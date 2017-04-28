from PIL import Image
start = 1
num = 51
imagePath = "/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/labeledImages/image"

for i in range(num):
    imNumber = start + i
    imageName = imagePath + str(imNumber) + '.ppm'
    imageSaveName = imagePath + str(imNumber) + '.png'
    im = Image.open(imageName)
    im.save(imageSaveName)