addpath(genpath('minFunc'));

load ('trainingData.mat')
load ('testingData.mat')

model = logisticL2(Xtrain, ytrain, 5);
yhat = model.predict(model, Xtest);
fprintf('Accuracy for SVM is %.4f\n', mean(yhat == ytest));