import numpy as np
import cv2
import scipy.io
from keras.models import load_model


if __name__ == "__main__":
    #Load test data
    testData = scipy.io.loadmat('../testingData.mat')
    trainingData = scipy.io.loadmat('../trainingData.mat')

    xTrain = trainingData['Xtrain']
    yTrain = trainingData['ytrain']

    xValid = testData['Xtest']
    yValid = testData['ytest']

    #Load model
    model = load_model('myKerasNet.h5')

    #Predictions on training data
    pyx_train = model.predict(xTrain)
    yhat_train = np.argmax(pyx_train, axis=1)
    yhat_train = np.reshape(yhat_train, (yhat_train.shape[0],1))

    #Predictions on test data
    pyx_test = model.predict(xValid)
    yhat_test = np.argmax(pyx_test, axis=1)
    yhat_test = np.reshape(yhat_test, (yhat_test.shape[0],1))

    #Save probabilities and predictions
    scipy.io.savemat('prediction.mat', {'yhat_train' : yhat_train, 'pyx_train' : pyx_train[:,1:8], 'yhat_test' : yhat_test, 'pyx_test' : pyx_test[:,1:8]})