nSplits = 3;
minErr = inf;
results = zeros(2, 50);
count = 1;
num_train = 60;
num_examples = 83;

for sigma = 0.1:0.1:5

    addLabels(0.5, 1, 83);
    load 'Data.mat'
    
    sizeImage = 120*160;
    Xtrain = X(1:sizeImage*num_train, :);
    ytrain = y(1:sizeImage*num_train);
    Xtest = X(sizeImage*num_train+1:sizeImage*num_examples, :);
    ytest = y(sizeImage*num_train+1:sizeImage*num_examples);
    
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
    fprintf('Accuracy with sigma = %.2f is %.2f\n', sigma, 1-validError);
    results(1, count) = sigma;
    results(2, count) = 1 - validError;
    
    % Keep track of the lowest validation error
    if validError < minErr
        minErr = validError;
        bestSigma = sigma;
        bestModel = model;
    end
    
    count = count + 1;

end

    
    
    