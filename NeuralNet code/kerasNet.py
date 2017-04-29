from keras.utils import np_utils, to_categorical
from keras.models import Sequential, load_model
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
import numpy as np
import scipy.io

class kerasNet:
    def __init__(self):
        self.trainingData = scipy.io.loadmat('../trainingData.mat')
        self.validationData = scipy.io.loadmat('../testingData.mat')

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

        nDimensions = xTrain.shape[1]
        
        # #Setup network architecture
        self.model = Sequential()
        self.model.add(Dense(64, input_shape=(nDimensions,), activation='relu', use_bias=True))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(64, activation='relu'))
        self.model.add(Dropout(0.5))
        self.model.add(Dense(8, activation='softmax'))
        self.model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])


        one_hot_labels = to_categorical(yTrain, num_classes=8)
        self.model.fit(xTrain, one_hot_labels, epochs=10, batch_size=128)

        one_hot_validation = to_categorical(yValid, num_classes=8)
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


