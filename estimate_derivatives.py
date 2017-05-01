from PIL import Image, ImageDraw
import matplotlib.pyplot as plt
import numpy as np
import math
from scipy import signal
import numpy.linalg as lin
import scipy.io

# START OF FUNCTIONS CARRIED FORWARD FROM ASSIGNMENT 2

def boxfilter (n):
    """ Create a box filter of size n by n. """
    b = np.ones( (n,n) ) #Start with array of ones
    b = b/b.size         #Divide by number of elements to make
    return b            #boxfilter sum up to 1
 
def gauss1d (sigma):
    """ Returns a 1D Gaussian filter for a given value of sigma """
    filter_size = math.ceil(sigma*6)
    
    if (filter_size % 2) == 1:    #Round up size of filter to nearest odd integer
        filter_size +=1
        
    k = math.floor(filter_size / 2);   #Calculate maximum value of vector x
    x = np.linspace(-k,k,filter_size)  #Create vector x from -k to k 
    G = np.exp(- (x*x) / (2*sigma**2)) #Calculate gaussian for each value in x
    G = G / np.sum(G)                  #Normalize filter
    return G

def gauss2d (sigma):
    """Returns a 2D Gaussian filter for a given value of sigma"""
    f = gauss1d (sigma)   #Calculate 1D gaussian 
    f = f[np.newaxis]     #Convert 1D array into 2D array to use with convolve2d
    #Calculate 2D gaussian filter by convolving a 1D Gaussian with its transpose
    G = signal.convolve2d(f, np.transpose(f)) #G is already normalized
    return G

def gaussconvolve2d (array, sigma):
    """ Applies gaussian convolution to a 2D array for the given value of sigma """     
    gaussian_filter = gauss2d(sigma) #Calculate 2D gaussian for given sigma
    #Use convolve2d to apply gaussian filter, keep same size of original array 
    new_array = signal.convolve2d(array, gaussian_filter, 'same')
    return new_array

# END OF FUNCTIONS CARRIED FORWARD FROM ASSIGNMENT 2

# Define a function, boxconvolve2d, to convolve an image with a boxfilter of size n
# (used in Estimate_Derivatives below).

def boxconvolve2d(image, n):
    """ Convolves image with boxfilter of size n by n """
    #Create boxfilter of size n x n
    boxFilter = boxfilter(n)
    #Convolve with image
    convolveBoxImage = signal.convolve2d(image, boxFilter, 'same')
    return convolveBoxImage
        

def Estimate_Derivatives(im1, sigma=1.5):
    """
    Estimate spatial derivatives of im1 and temporal derivative from im1 to im2.

    Smooth im1 with a 2D Gaussian of the given sigma.  Use first central difference to
    estimate derivatives.

    """
    # UNCOMMENT THE NEXT FOUR LINES WHEN YOU HAVE DEFINED THE FUNCTIONS ABOVE
    im1_smoothed = gaussconvolve2d(im1,sigma)
    Ix, Iy = np.gradient(im1_smoothed)
  
    return Ix, Iy


#Main program starts here ###
allIx = []
allIy = []
for i in range(1,101):
    imageName = 'labeledImages/image'+ str(i)+ '.png'
    PIL_im1 = Image.open(imageName)
    PIL_im1 = PIL_im1.convert('L')
    im1 = np.asarray(PIL_im1)
    Ix, Iy = Estimate_Derivatives(im1)
    Ix = np.reshape(Ix, 120*160, 1)
    Iy = np.reshape(Iy, 120*160, 1)
    allIx = np.append(allIx, Ix)
    allIy = np.append(allIy, Iy)

scipy.io.savemat('estimated_derivatives.mat', {'Ix' : allIx, 'Iy' : allIy})