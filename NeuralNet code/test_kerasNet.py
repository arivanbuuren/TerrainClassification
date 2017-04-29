import numpy as np
import cv2
import scipy.io
from keras.models import load_model


if __name__ == "__main__":
    #Load test data
    testData = scipy.io.loadmat('../testingData.mat')
    xValid = testData['Xtest']
    yValid = testData['ytest']

    #Load model
    model = load_model('myKerasNet.h5')
    pyx = model.predict(xValid)

    yhat = np.argmax(pyx, axis=1)
    yhat = np.reshape(yhat, (yhat.shape[0],1))
    print yhat.shape
    scipy.io.savemat('prediction.mat', {'yhat' : yhat, 'pyx' : pyx[:,1:8]})