load 'trainingData.mat'
load 'testingData.mat'

load 'predictionGMM.mat'
ytrain_GMM = yhat_train_GMM;
ytest_GMM = yhat_test_GMM;

load 'predictionDT/yhat.mat'
load 'predictionDT/ytrain_predict.mat'
ytrain_DT = ytrain_predict;
ytest_DT = yhat;

load 'NeuralNet code/prediction.mat'
ytrain_NN = yhat_train_NN;
ytest_NN = yhat_test_NN;

Xtrain = [ytrain_NN ytrain_GMM ytrain_DT];
Xtest = [ytest_NN ytest_GMM ytest_DT];
Xtrain = double(Xtrain);
Xtest = double(Xtest);
ytrain = double(ytrain);
ytest = double(ytest);

Xtrain_sub = Xtrain(1:120*160, :);
ytrain_sub = ytrain(1:120*160);

model = fitcecoc(Xtrain_sub, ytrain_sub);

acc = 1 - resubLoss(model)
