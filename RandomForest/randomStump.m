function [model] = randomStump(X,y)
% [model] = randomStump(X,y)
%
% Fits a random decision stump that splits on a single variable.

% Compute number of training examples and number of features
[n,d] = size(X);

% Computer number of class lables
k = max(y);

% Address the trivial case where we do not split
count = accumarray(y,ones(size(y)),[k 1]); % Counts the number of occurrences of each class
[maxCount,maxLabel] = max(count);

% Compute total entropy (needed for information gain)
p = count/sum(count); % Convert counts to probabilities
entropyTotal = -sum(p.*log0(p));

maxGain = 0;
splitVariable = [];
splitThreshold = [];
splitLabel0 = maxLabel;
splitLabel1 = [];

%Find subset of sqrt(d) randomly choosen features
for i = 1:round(sqrt(d))
    nextd(i) = ceil(d*rand());
    if i == 1
        newX = [X(:,nextd(i))];
    else
        newX = [newX X(:,nextd(i))];
    end
end
X = newX;
[n,d] = size(X); %Get new size of X
% Loop over features looking for the best split
if any(y ~= y(1))
    for j = 1:d
        thresholds = sort(unique(X(:,j)));
        
        for t = thresholds'
            
            % Count number of class labels where the feature is greater than threshold
            yVals = y(X(:,j) > t);
            count1 = accumarray(yVals,ones(size(yVals)),[k 1]);
            count0 = count-count1;
                        
            % Compute infogain
            p1 = count1/sum(count1);
            p0 = count0/sum(count0);
            H1 = -sum(p1.*log0(p1));
            H0 = -sum(p0.*log0(p0));
            prob1 = sum(X(:,j) > t)/n;
            prob0 = 1-prob1;
            infoGain = entropyTotal - prob1*H1 - prob0*H0;
            
            % Compare to minimum error so far
            if infoGain > maxGain
                % This is the lowest error, store this value
                maxGain = infoGain;
                splitVariable = nextd(j);
                splitThreshold = t;
    
                % Compute majority class
                [maxCount,splitLabel1] = max(count1);
                [maxCount,splitLabel0] = max(count0);
            end
        end
    end
end
model.splitVariable = splitVariable;
model.splitThreshold = splitThreshold;
model.label1 = splitLabel1;
model.label0 = splitLabel0;
model.predict = @predict;
end

function [y] = predict(model,X)
[t,d] = size(X);

if isempty(model.splitVariable)
    y = model.label0*ones(t,1);
else
    y = zeros(t,1);
    for n = 1:t
        if X(n,model.splitVariable) > model.splitThreshold
            y(n,1) = model.label1;
        else
            y(n,1) = model.label0;
        end
    end
end
end