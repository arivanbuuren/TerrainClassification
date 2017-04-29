% Load X and y variable
%load 'Data.mat'

%num_train = 75;
%num_examples = 83;

%sizeImage = 120*160;
%Xtrain = X(1:sizeImage*num_train, :);
%ytrain = y(1:sizeImage*num_train);
%Xtest = X(sizeImage*num_train+1:sizeImage*num_examples, :);
%ytest = y(sizeImage*num_train+1:sizeImage*num_examples);

load 'trainingData.mat'
load 'testingData.mat'

[n,d] = size(Xtrain);
depth = 1;

model = decisionTreeInfoGain(Xtrain, ytrain, depth);

yhat = model.predict(model, Xtest);
testError = mean(yhat ~= ytest);
fprintf('Test accuracy is %.2f\n', 1-testError);

save('predictionDecisionTree.mat', 'yhat')
