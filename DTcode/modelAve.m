load '../BestDataset/trainingData.mat'
load '../BestDataset/testingData.mat'

load 'predictionDT.mat';
yhat_test_DT = yhat;

load '../GMMcode/predictionGMMwo.mat';

load '../NeuralNet code/prediction_wo_NN.mat'

Xtrain = [yhat_train_DT yhat_train_GMM yhat_train_NN];
Xtest = [yhat_test_DT yhat_test_GMM yhat_test_NN];

[n, d] = size(Xtrain);

%% Fit decision tree and compute error
minErr = inf;
nSplits = 3;
for depth = 1:15
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
    fprintf('Accuracy with depth = %d is %.4f\n', depth, 1-validError);
    
    % Keep track of the lowest validation error
    if validError < minErr
        minErr = validError;
        bestDepth = depth;
        bestYhat = yhat;
    end
end
    
fprintf('Best tree depth is %d\n', bestDepth);

model = decisionTreeInfoGain(Xtrain, ytrain, bestDepth);
%yhat_train = model.predict(model, Xtrain);
%tStart = tic;
yhat = model.predict(model, Xtest);
%tElapsed = toc(tStart); 
%predTime = tElapsed/25;
testAcc = mean(yhat == ytest);
fprintf('Test accuracy is %.4f\n', testAcc);
%save('predictionDT.mat', 'yhat', 'yhat_train_DT', 'predTime');
