from keras.utils import np_utils, to_categorical
from keras.models import Sequential, load_model
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
import processImages 
import numpy as np
import scipy.io

class kerasNet:
    def __init__(self):
        self.trainingData = scipy.io.loadmat('trainingData.mat')
        self.validationData = scipy.io.loadmat('testingData.mat')

    def train(self):
        print "Training neural net keras"

        #Get training examples
        xTrain = self.trainingData['Xtrain']
        yTrain = self.trainingData['ytrain']

        xValid = self.validationData['Xtest']
        yValid = self.validationData['ytest']

        #Setup network architecture
        self.model = Sequential()
        self.model.add(Dense(64, input_shape=(3,), activation='relu', use_bias=True))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(64, activation='relu'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(6, activation='softmax'))
        self.model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])


        one_hot_labels = to_categorical(yTrain, num_classes=6)
        self.model.fit(xTrain, one_hot_labels, epochs=100, batch_size=128)

        one_hot_validation = to_categorical(yValid, num_classes=6)
        score = self.model.evaluate(xValid, one_hot_validation, verbose=0)
        print('Test accuracy:', score[1])
        self.model.save('myKerasNet.h5')

    def predict(self, xTest):
        yhat = self.model.predict(xTest)
        return yhat

if __name__ == "__main__":
    model = kerasNet()
    model.train()
    # Xtest = model.trainingData['Xtrain']
    # Xhat = Xtest[0:120*160,:]
    # prediction = model.predict(Xhat)
    # print "prediction: ", prediction
    # print prediction.shape 


