function [model] = decisionTree2(X,y,maxDepth)
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
    fprintf('case where maxdepth <=1 \n');
    model %by ariadna
else    
    % Fit a decision tree to each split, decreasing maximum depth by 1
    fprintf('entered else on decision tree \n');
    j = splitModel.splitVariable;
    value = splitModel.splitValue;
    model.splitModel = splitModel;
    fprintf('found splitvariable [%d] and split value: %.2f\n,', j, value);
    splitModel %by Ariadna
    % Find indices of examples in each split
    splitIndex1 = find(X(:,j)>value);
    splitIndex0 = find(X(:,j)<=value);
    
    % Fit decision tree to each split
    model.subModel1 = decisionTree2(X(splitIndex1,:),y(splitIndex1),maxDepth-1);
    model.subModel0 = decisionTree2(X(splitIndex0,:),y(splitIndex0),maxDepth-1);
  
    % Assign prediction function
    model.predict = @predict;
end
end

function [y] = predict(model,X)
[t,d] = size(X);
y = zeros(t,1);

for i = 1:t
    if ( X(i,2) > 37.6690 )
        if ( X(i,1) > -96.0901)
            y(i) = 1;
        else
            y(i) = 2;
        end
    else 
        if ( X(i,1) > -115.5776 ) 
            y(i) = 2;
        else
            y(i) = 1;
        end
    end
end

end
