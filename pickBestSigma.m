minErr = inf;
nSplits = 4;

for sigma = 0.1:0.1:5
    getTrainingData(sigma, 11, 50);
    load 'trainingData.mat';
    [n, d] = size(Xtrain);
    
    validError = 0;
    for split = 1:nSplits
        
        % Gest the training set and test set indices
        testStart = 1 + (n/nSplits)*(split-1);
        testEnd = (n/nSplits)*split;
        trainNdx = [1:testStart-1 testEnd+1:n];
        testNdx = testStart:testEnd;
        sizeValid = testEnd-testStart+1;
        sizeTrain = n-sizeValid;
        
        Xtrain_v = Xtrain(trainNdx, :);
        ytrain_v = ytrain(trainNdx, :);
        Xvalid = Xtrain(testNdx, :);
        yvalid = ytrain(testNdx, :);
        
        % Train on the training set
        model = generativeGaussian(Xtrain_v, ytrain_v);
        
        % Compute the error on the validation set
        yhat = model.predict(model, Xvalid);
        validError = validError + mean(yhat ~= yvalid);
        
    end
    
    validError = validError/nSplits;
    fprintf('Accuracy with sigma = %.2f is %.2f', sigma, 1-validError);
    
    % Keep track of the lowest validation error
    if validError < minError
        minErr = validError;
        bestSigma = sigma;
    end

end

    
    
    