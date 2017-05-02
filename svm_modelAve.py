from sklearn import svm
import scipy.io as sio
import numpy as np

path = '/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/'
prediction_NN = sio.loadmat(path + 'NeuralNet code/prediction_wo_NN.mat')

prediction_GMM = sio.loadmat(path + 'GMMcode/predictionGMMwo.mat')

prediction_DT = sio.loadmat(path + 'DTcode/predictionDTwo.mat')

yhat_train_NN = prediction_NN['yhat_train_NN']
yhat_train_GMM = prediction_GMM['yhat_train_GMM']
yhat_train_DT = prediction_DT['yhat_train_DT']
Xtrain = np.concatenate((yhat_train_NN, yhat_train_GMM, yhat_train_DT), axis = 1)

yhat_test_NN = prediction_NN['yhat_test_NN']
yhat_test_GMM = prediction_GMM['yhat_test_GMM']
yhat_test_DT = prediction_DT['yhat_test_DT']
Xtest = np.concatenate((yhat_test_NN, yhat_test_GMM, yhat_test_DT), axis = 1)

trainingData = sio.loadmat(path + 'BestDataset/trainingData.mat')
testingData = sio.loadmat(path + 'BestDataset/testingData.mat')
ytrain = trainingData['ytrain']
ytest = testingData['ytest']

clf = svm.SVC(decision_function_shape='ovr')
print 'Start Fitting Model'
clf.fit(Xtrain, ytrain.reshape((1440000, )))
print 'Done Fitting Model'
print 'Making Pridictions'
yhat = clf.predict(Xtest);
print np.mean(yhat == ytest.reshape((1440000, )));
