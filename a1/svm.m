load 'trainingData.mat'
load 'testingData.mat'

model = fitcecoc(Xtrain, ytrain);
1-resubLoss(model)