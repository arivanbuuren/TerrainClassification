load 'Data&Results_withoutIx/trainingData.mat'
load 'Data&Results_withoutIx/testingData.mat'

[n,d] = size(Xtrain);

model = decisionTreeInfoGain(Xtrain, ytrain, 11);
yhat_train_DT = model.predict(model, Xtrain);
yhat = model.predict(model, Xtest);
testAcc = mean(yhat == ytest);
fprintf('Test accuracy is %.4f\n', testAcc);