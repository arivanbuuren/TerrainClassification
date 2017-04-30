%This program fits a Gaussian mixture model to make pixel-wise
%classification

close all;
clear;

%Load data
load 'trainingData.mat'
load 'testingData.mat'

% Fit GMM on train data and compute accuracy 

model = generativeGaussian(Xtrain, ytrain);
[yhat_train, pyx_train] = model.predict(model,Xtrain);
fprintf('Gaussian Gen. Model. training accuracy is %.2f\n', mean(yhat_train == ytrain));

% Make predictions on test data
[yhat_test, pyx_test] = model.predict(model, Xtest);
fprintf('Gaussian Gen. Model. testing accuracy is %.2f\n', mean(yhat_test == ytest));

%Save predictions and probabilities on training data
pyx_train = pyx_train(:,1:7);
pyx_test=pyx_test(:,1:7);
save('predictionGMM.mat', 'yhat_train', 'pyx_train', 'yhat_test', 'pyx_test');
