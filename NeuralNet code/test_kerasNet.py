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
    yhat = model.predict(xValid)
    yhat = np.argmax(yhat, axis=1)
    yhat = np.reshape(yhat, (yhat.shape[0],1))
    print yhat.shape
    scipy.io.savemat('prediction.mat', {'yhat' : yhat})