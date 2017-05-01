import numpy as np
import cv2
import scipy.io
import time
from keras.models import load_model


if __name__ == "__main__":
    #Load test data
    testData = scipy.io.loadmat('../ignoreThis/testingData.mat')
    trainingData = scipy.io.loadmat('../ignoreThis/trainingData.mat')

    xTrain = trainingData['Xtrain']
    yTrain = trainingData['ytrain']

    xValid = testData['Xtest']
    yValid = testData['ytest']

    # xTrain = xTrain[:,0:3]
    # xValid = xValid[:,0:3]
    #Load model
    model = load_model('myKerasNet3.h5')

    #Predictions on training data
    pyx_train = model.predict(xTrain)
    yhat_train = np.argmax(pyx_train, axis=1)
    yhat_train = np.reshape(yhat_train, (yhat_train.shape[0],1))
    print "Train accuracy: ", np.mean(yhat_train == yTrain)

    #Predictions on test data
    tStart = time.time()
    pyx_test = model.predict(xValid)
    yhat_test = np.argmax(pyx_test, axis=1)
    tElapsed = time.time() - tStart

    yhat_test = np.reshape(yhat_test, (yhat_test.shape[0],1))
    print "Test accuracy: ", np.mean(yhat_test == yValid)
    predTimeNN = tElapsed / 25
    print "Average prediction time in one image: ", predTimeNN, " seconds"

    #Save probabilities and predictions
    scipy.io.savemat('prediction_with_NN.mat', {'yhat_train_NN' : yhat_train, 'pyx_train_NN' : pyx_train[:,1:8], 'yhat_test_NN' : yhat_test, 'pyx_test_NN' : pyx_test[:,1:8], 'predTimeNN' : predTimeNN})