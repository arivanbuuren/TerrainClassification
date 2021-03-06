addpath(genpath('Data&Results_withoutIx'));
load 'Data&Results_withoutIx/trainingData.mat';
load 'predictionGMM.mat';
ypredict_GMM = yhat_train_GMM;
fprintf('Accuracy for GMM is %.4f\n', mean(ytrain == ypredict_GMM));
load 'prediction_woIx.mat';
ypredict_NN = yhat_train_NN;
fprintf('Accuracy for NN is %.4f\n', mean(ytrain == ypredict_NN));
load 'predictionDT.mat';
ypredict_DT = yhat_train_DT;
fprintf('Accuracy for Decision Tree is %.4f\n', mean(ytrain == ypredict_DT));

ypredict = [ypredict_GMM ypredict_NN ypredict_DT];

%depth = 5;
%model = decisionTreeInfoGain(ypredict, ytrain, depth);
%yhat = model.predict(model, ypredict);
%fprintf('Accuracy for Averaging with Decision Tree is %.4f\n', mean(ytrain == yhat));

Xtrain = ypredict;
[n, d] = size(Xtrain);

%% Fit decision tree and compute error
minErr = inf;
nSplits = 5;
for depth = 2:10
    validError = 0;
    for split = 1:nSplits
        
        % Get the training set and test set indices
        testStart = 1 + (n/nSplits)*(split-1);
        testEnd = (n/nSplits)*split;
        trainNdx = [1:testStart-1 testEnd+1:n];
        testNdx = testStart:testEnd;
        sizeValid = testEnd-testStart+1;
        sizeTrain = n-sizeValid;
        
        % Train on the training set
        model = decisionTreeInfoGain(Xtrain(trainNdx, :), ytrain(trainNdx), depth);
        yprediction = model.predict(model, Xtrain(trainNdx, :));
        trainError = mean(yprediction ~= ytrain(trainNdx));
        
        % Compute the error on the validation set
        yhat = model.predict(model, Xtrain(testNdx, :));
        validError = validError + mean(yhat ~= ytrain(testNdx));
    end
    validError = validError/nSplits;
    fprintf('Accuracy with depth = %d is %.4f\n', depth, 1-validError);
    
    % Keep track of the lowest validation error
    if validError < minErr
        minErr = validError;
        bestDepth = depth;
    end
end
    
fprintf('Best tree depth is %d', bestDepth);

model = decisionTreeInfoGain(Xtrain, ytrain, bestDepth);
yhat = model.predict(model, Xtrain);
acc = mean(yhat == ytrain);
fprintf('Accuracy after averaging is %.4f\n', acc);


