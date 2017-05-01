%This program fits a Gaussian mixture model to make pixel-wise
%classification

close all;
clear;

%Load data
load 'Data&Results_withoutIx/trainingData.mat'
load 'Data&Results_withoutIx/testingData.mat'

% Fit GMM on train data and compute accuracy 

model = generativeGaussian(Xtrain, ytrain);
[yhat_train_GMM, pyx_train_GMM] = model.predict(model,Xtrain);
fprintf('Gaussian Gen. Model. training accuracy is %.2f\n', mean(yhat_train_GMM == ytrain));

% Make predictions on test data
[yhat_test_GMM, pyx_test_GMM] = model.predict(model, Xtest);
fprintf('Gaussian Gen. Model. testing accuracy is %.2f\n', mean(yhat_test_GMM == ytest));

%Save predictions and probabilities on training data
pyx_train_GMM = pyx_train_GMM(:,1:7);
pyx_test_GMM = pyx_test_GMM(:,1:7);
save('Data&Results_withoutIx/predictionGMM.mat', 'yhat_train_GMM', 'pyx_train_GMM', 'yhat_test_GMM', 'pyx_test_GMM');
