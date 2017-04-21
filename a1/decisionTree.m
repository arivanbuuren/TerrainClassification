function [model] = decisionTree(X,y,maxDepth)
% [model] = decisionTree(X,y)
%
% Fits a decision tree using greedy recursive splitting

[n,d] = size(X);

% Learn a decision stump
splitModel = decisionStump(X,y);

if maxDepth <= 1 || isempty(splitModel.splitVariable)
    % If we have reached the maximum depth or the decision stump does
    % nothing, use the decision stump
    model = splitModel;
%     model %by ariadna
else    
    % Fit a decision tree to each split, decreasing maximum depth by 1
    j = splitModel.splitVariable;
    value = splitModel.splitValue;
    model.splitModel = splitModel;
%     splitModel %by Ariadna
    % Find indices of examples in each split
    splitIndex1 = find(X(:,j)>value);
    splitIndex0 = find(X(:,j)<=value);
    
    % Fit decision tree to each split
    model.subModel1 = decisionTree(X(splitIndex1,:),y(splitIndex1),maxDepth-1);
    model.subModel0 = decisionTree(X(splitIndex0,:),y(splitIndex0),maxDepth-1);
  
    % Assign prediction function
    model.predict = @predict;
end
end

function [y] = predict(model,X)
[t,d] = size(X);
y = zeros(t,1);

% Predict based on first split
splitModel = model.splitModel;
yhat = splitModel.predict(splitModel,X);

if isempty(splitModel.splitVariable)
    % If no further splitting, return the majority label
    y = splitModel.splitSat*ones(T,1);
else
    % Recurse on both sub-models
    j = splitModel.splitVariable;
    value = splitModel.splitValue;
    splitIndex1 = find(X(:,j)>value);
    splitIndex0 = find(X(:,j)<=value);
    
    subModel1 = model.subModel1;
    subModel0 = model.subModel0;
    
    y(splitIndex1) = subModel1.predict(subModel1,X(splitIndex1,:));
    y(splitIndex0) = subModel0.predict(subModel0,X(splitIndex0,:));
end
end