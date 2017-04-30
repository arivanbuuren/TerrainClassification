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
        print "Training convolutional neural network using keras"

        #Get training examples
        xTrain = self.trainingData['Xtrain']
        yTrain = self.trainingData['ytrain']

        xTrain = np.reshape(xTrain, (len(xTrain)/(120*160), 160,120,4))

        for i in range(len(yTrain)):
            if yTrain[i] == 8: 
                yTrain[i] = 0

        yTrain = np.reshape(yTrain, (len(yTrain)/(120*160), 160,120))

        xValid = self.validationData['Xtest']
        yValid = self.validationData['ytest']

        xValid = np.reshape(xValid, (len(xValid)/(120*160), 160,120,4))

        for i in range(len(yValid)):
            if yValid[i] == 8: 
                yValid[i] = 0

        yValid = np.reshape(yValid, (len(yValid)/(120*160), 160,120))
        nDimensions = xTrain.shape[1]
        
        # #Setup network architecture
        self.model = Sequential()
        self.model.add(Convolution2D(32, (3, 3), input_shape=(160,120,4), activation='relu', use_bias=True))
        self.model.add(MaxPooling2D(pool_size=(2, 2)))
        self.model.add(Flatten())
        self.model.add(Dense(32,activation='relu'))
        self.model.add(Dense(8, activation='softmax'))
        self.model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

        #Fit model
       # one_hot_labels = to_categorical(yTrain, num_classes=8)
        self.model.fit(xTrain, yTrain, epochs=100, batch_size=128)

        # #Save model
        # self.model.save('myKerasConvNet.h5')

        # #Get model accuracy
        # one_hot_validation = to_categorical(yValid, num_classes=8)
        # score = self.model.evaluate(xValid, one_hot_validation, verbose=0)
        # print('Test accuracy:', score[1])
     

    def predict(self, xTest):
        yhat = self.model.predict(xTest)
        return yhat

if __name__ == "__main__":
    model = kerasNet()
    model.train()


