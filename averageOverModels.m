load 'prediction.mat';
yhat_CNN = yhat;

load 'predictionGMM.mat';
yhat_GMM = yhat;

load 'predictionDecisionTree.mat'
yhat_DT = yhat;

load 'testingData.mat'

Yhat = [yhat_CNN yhat_GMM yhat_DT];
yhat = mode(Yhat, 2);
accuracy = mean(yhat ~= ytest);

fprintf('Accuracy of averaging is %.2f\n', accuracy);
