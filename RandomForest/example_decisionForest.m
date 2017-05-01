%Script to run problem 2.2 Assignment 2 Machine Learning Decision Forest 
%Load X and y variable
% clear
% clc
load('../trainingData.mat');
load('../testingData.mat');
X = Xtrain;
y = ytrain;
[n,d] = size(X);
depth = 5;
nBootstraps = 30;
model = decisionForest(X,y,depth,nBootstraps);
% Evaluate training error
yhat = model.predict(model,X);
training_error = sum(yhat ~= y)/n;
fprintf('Training error with depth-%2d decision forest: %.2f\n',depth,training_error);

% Evaluate test error 
[m,d] = size(Xtest);
yhat = model.predict(model,Xtest);
test_error = sum(yhat ~= ytest)/m;
fprintf('Test     error with depth-%2d decision forest: %.2f\n',depth,test_error);
