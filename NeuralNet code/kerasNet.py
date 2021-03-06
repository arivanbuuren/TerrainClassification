from keras.utils import np_utils, to_categorical
from keras.models import Sequential, load_model
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
import numpy as np
import scipy.io

class kerasNet:
    def __init__(self):
        self.trainingData = scipy.io.loadmat('../ignoreThis/trainingData.mat')
        self.validationData = scipy.io.loadmat('../ignoreThis/testingData.mat')

    def train(self):
        print "Training neural net keras"

        #Get training examples
        xTrain = self.trainingData['Xtrain']
        yTrain = self.trainingData['ytrain']

        for i in range(len(yTrain)):
            if yTrain[i] == 8: 
                yTrain[i] = 0

        xValid = self.validationData['Xtest']
        yValid = self.validationData['ytest']

        for i in range(len(yValid)):
            if yValid[i] == 8: 
                yValid[i] = 0

        xTrain = xTrain[:,0:3]
        xValid = xValid[:,0:3]
        nDimensions = xTrain.shape[1]
        print "training with ", nDimensions, " features"
        # #Setup network architecture
        self.model = Sequential()
        self.model.add(Dense(64, input_shape=(nDimensions,), activation='relu', use_bias=True))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(64, activation='tanh'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(64, activation='tanh'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(64, activation='tanh'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(8, activation='softmax'))
        self.model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

        #Fit model
        one_hot_labels = to_categorical(yTrain, num_classes=8)
        self.model.fit(xTrain, one_hot_labels, epochs=50, batch_size=120*160)

        #Save model
        self.model.save('myKerasNet4.h5')

        #Get model accuracy
        one_hot_validation = to_categorical(yValid, num_classes=8)
        score = self.model.evaluate(xValid, one_hot_validation, verbose=0)
        print('Test accuracy:', score[1])
     

    def predict(self, xTest):
        yhat = self.model.predict(xTest)
        return yhat

if __name__ == "__main__":
    model = kerasNet()
    model.train()


