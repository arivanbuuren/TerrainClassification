function [model] = randomTree(X,y,maxDepth)
% [model] = randomTree(X,y)
%
% Fits a decision tree that splits on a sequence of single variables.

[n,d] = size(X);

% Learn a random decision stump
splitModel = randomStump(X,y);

if maxDepth <= 1 || isempty(splitModel.splitVariable)
    % If we have reached the maximum depth or the decision stump does
    % nothing, use the decision stump
    model = splitModel;
else
    % Fit a decision tree to each split, decreasing maximum depth by 1
    d = splitModel.splitVariable;
    t = splitModel.splitThreshold;
    model.splitModel = splitModel;
    
    % Find indices of examples in each split
    splitIndex1 = find(X(:,d) > t);
    splitIndex0 = find(X(:,d) <= t);
    
    % Fit decision tree to each split
    model.subModel1 = randomTree(X(splitIndex1,:),y(splitIndex1),maxDepth-1);
    model.subModel0 = randomTree(X(splitIndex0,:),y(splitIndex0),maxDepth-1);
    
    % Assign prediction function
    model.predict = @predict;
end
end

function [y] = predict(model,X)
[t,d] = size(X);
y = zeros(t,1);

splitModel = model.splitModel;
if isempty(splitModel.splitVariable)
    % If no further splitting, return the majority label
    y = splitModel.label1*ones(t,1);
else
    % Recurse on both sub-models
    d = splitModel.splitVariable;
    t = splitModel.splitThreshold;
    
    splitIndex1 = find(X(:,d) > t);
    splitIndex0 = find(X(:,d) <= t);
    
    subModel1 = model.subModel1;
    subModel0 = model.subModel0;
    
    y(splitIndex1) = subModel1.predict(subModel1,X(splitIndex1,:));
    y(splitIndex0) = subModel0.predict(subModel0,X(splitIndex0,:));
end
end