load 'trainingData.mat'
load 'testingData.mat'

[n,d] = size(Xtrain);

model = decisionTreeInfoGain(Xtrain, ytrain, 10);
yhat = model.predict(model, Xtest);
testAcc = mean(yhat == ytest);
fprintf('Test accuracy is %.4f\n', testAcc);