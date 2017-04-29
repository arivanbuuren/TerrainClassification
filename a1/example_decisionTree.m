load 'trainingData.mat'
load 'testingData.mat'

[n,d] = size(Xtrain);

%% Fit decision tree and compute error
minErr = inf;
nSplits = 3;
for depth = 1:20
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
        ypredict = model.predict(model, Xtrain(trainNdx, :));
        trainError = sum(ypredict ~= ytrain(trainNdx))/sizeTrain;
        
        % Compute the error on the validation set
        yhat = model.predict(model, Xtrain(testNdx, :));
        validError = validError + sum(yhat ~= ytrain(testNdx))/sizeValid;
    end
    validError = validError/nSplits;
    fprintf('Error with depth = %d is %.2f\n', depth, validError);
    
    % Keep track of the lowest validation error
    if validError < minErr
        minErr = validError;
        bestDepth = depth;
        bestYhat = yhat;
    end
end
    
fprintf('Best tree depth is %d', bestDepth);

[sizeTest, ~] = size(Xtest);
model = decisionTreeInfoGain(Xtrain, ytrain, bestDepth);
yhat = model.predict(model, Xtest);
testError = sum(yhat ~= ytest)/sizeTest;
fprintf('Test error is %.2f\n', testError);
