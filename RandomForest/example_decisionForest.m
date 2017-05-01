%Script to run problem 2.2 Assignment 2 Machine Learning Decision Forest 
%Load X and y variable
clear
clc
load('../NewData/trainingData.mat');
load('../NewData/testingData.mat');
X = Xtrain;
y = ytrain;
[n,d] = size(X);
fprintf('running random forest\n');

%Parameters from CV
depth = 11;
nBootstraps = 11;

model = decisionForest(X,y,depth,nBootstraps);
% Evaluate training error
yhat = model.predict(model,X);
training_error = sum(yhat ~= y)/n;
fprintf('Training error with depth-%2d trees-%2d decision forest: %.2f\n',depth,nBootstraps,training_error);

yhat_train_RF = yhat;

% Evaluate test error 
[m,d] = size(Xtest);

tStart = tic;
yhat = model.predict(model,Xtest);
tElapsed = toc(tStart);

test_error = sum(yhat ~= ytest)/m;
fprintf('Test     error with depth-%2d trees-%2d decision forest: %.2f\n\n',depth,nBootstraps, test_error);
predTimeRF = tElapsed / (m/(120*160));
fprintf('Average prediction time for one image: %.2f seconds\n', predTimeRF);

yhat_test_RF = yhat;

save('predictionDTwith.mat', 'yhat_train_RF', 'yhat_test_RF', 'predTimeRF');
