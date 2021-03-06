%This program fits a Gaussian mixture model to make pixel-wise
%classification

close all;
clear;clc;

%Load data
load '../BestDataset/trainingData.mat'
load '../BestDataset/testingData.mat'
% Xtrain = Xtrain(:,1:3);
% Xtest = Xtest(:,1:3);

% Fit GMM on train data and compute accuracy 

model = generativeGaussian(Xtrain, ytrain);
[yhat_train_GMM, pyx_train_GMM] = model.predict(model,Xtrain);
fprintf('Gaussian Gen. Model. training accuracy is %.2f\n', mean(yhat_train_GMM == ytrain));

% Make predictions on test data
tStart = tic;
[yhat_test_GMM, pyx_test_GMM] = model.predict(model, Xtest);
tElapsed = toc(tStart);
fprintf('Gaussian Gen. Model. testing accuracy is %.2f\n', mean(yhat_test_GMM == ytest));

%Get average prediction time
predTimeGMM =  tElapsed/(length(ytest)/(120*160));
fprintf('Average prediction time for one image is: %.2f\n',predTimeGMM);

%Save predictions and probabilities on training data
pyx_train_GMM = pyx_train_GMM(:,1:7);
pyx_test_GMM = pyx_test_GMM(:,1:7);
save('predictionGMMwith.mat', 'yhat_train_GMM', 'pyx_train_GMM', 'yhat_test_GMM', 'pyx_test_GMM', 'predTimeGMM');
