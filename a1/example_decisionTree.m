% Load X and y variable
load trainingData.mat
load testingData.mat
[n,d] = size(Xtrain);

%% Fit decision tree and compute error
depth = 12;

% Calling decisionTreeInfoGain by Ariadna

model = decisionTreeInfoGain(Xtrain,ytrain,depth);

% Evaluate training error
yhat = model.predict(model,Xtest);
error = sum(yhat ~= ytest)/n;
fprintf('Error with depth-%d decision tree info-gain: %.2f\n',depth,error);

% Plot classifier
%figure(2);
%classifier2Dplot(X,y,model);

