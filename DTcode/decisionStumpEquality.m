function [model] = decisionStumpEquality(X,y)
% [model] = decisionStumpEquality(X,y)
%
% Fits a decision stump that splits based on discretizing a single variable
% and checking for equality

[n,d] = size(X);

% Address the case where we do not split
y_mode = mode(y);
minError = sum(y ~= y_mode);
splitVariable = [];
splitValue = [];
splitSat = y_mode;
splitNot = [];

if any(y ~= y(1)) % First check that all labels are not equal
    
    % Discretize X so that checking for equality makes sense
    X = round(X);
    
    for j = 1:d
        for i = 1:n
            % Choose value to equate to
            value = X(i,j);
            
            % Find most likely class when rule is satisfied 
            %   and not satisfied
            y_sat = mode(y(X(:,j) == value));
            y_not = mode(y(X(:,j) ~= value));
            
            % Make predictions
            yhat = y_sat*ones(n,1);
            yhat(X(:,j) ~= value) = y_not;
            
            % Compute error
            error = sum(yhat ~= y);
            
            % Update best rule
            if error < minError
               minError = error;
               splitVariable = j;
               splitValue = value;
               splitSat = y_sat;
               splitNot = y_not;
            end
        end
    end
end

model.splitVariable = splitVariable;
model.splitValue = splitValue;
model.splitSat = splitSat;
model.splitNot = splitNot;
model.predict = @predict;
end

function [y] = predict(model,X)
[t,d] = size(X);

% Discretize for equality rule
X = round(X);

if isempty(model.splitVariable)
    y = model.splitSat*ones(t,1);
else
    y = zeros(t,1);
    for i = 1:t
        if X(i,model.splitVariable) == model.splitValue
            y(i,1) = model.splitSat;
        else
            y(i,1) = model.splitNot;
        end
    end
end
end