% Load training {X,y} and testing {Xtest,ytest} variables
load citiesSmall.mat
[n,d] = size(X);

depth = 2;
model = decisionTreeInfoGain(X,y,depth);

% Evaluate training error
yhat = model.predict(model,X);
errorTrain = sum(yhat ~= y)/n;
fprintf('Training error with depth-%d decision tree: %.3f\n',depth,errorTrain);

% Evaluate test error
t = size(Xtest,1);
yhat = model.predict(model,Xtest);
errorTest = sum(yhat ~= ytest)/t;
fprintf('Test error with depth-%d decision tree: %.3f\n',depth,errorTest);
