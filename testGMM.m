close all;
clear;

getTrainingData(0.5, 1, 75);
getTestingData(0.5, 76, 83);

load 'trainingData.mat'
load 'testingData.mat'

model = generativeGaussian(Xtrain, ytrain);
yhat = model.predict(model, Xtest);
fprintf('Gaussian Gen. Model. accuracy is %.2f\n', mean(yhat == ytest));%