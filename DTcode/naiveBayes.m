function [model] = naiveBayes(X,y)
% [model] = naiveBayes(X,y,k)
%
% Implementation of navie Bayes classifier for binary features

% Compute number of training examples and number of features
[N,D] = size(X);

% Computer number of class lables
C = max(y);

counts = zeros(C,1);
for c = 1:C
    counts(c) = sum(y==c);
end
p_y = counts/N; % This is the probability of each class, p(y(i) = c)

% We will store:
%   p(x(i,j) = 1 | y(i) = c) as p_xy(j,1,c)
%   p(x(i,j) = 0 | y(i) = c) as p_xy(j,2,c)

%Compute the estimates of all conditional probabilities required by NB
for j=1:D
    for c=1:C
        indexc = find(y==c); %Find indexes where y == c
        p_xy(j,1,c) = full( sum(X(indexc,j))/ counts(c) ); 
        p_xy(j,2,c) = 1 -  p_xy(j,1,c);
    end
end

model.C = C;
model.p_y = p_y;
model.p_xy = p_xy;
model.predict = @predict;
end

function [yhat] = predict(model,Xtest)
[T,D] = size(Xtest);
C = model.C;
p_y = model.p_y;
p_xy = model.p_xy;

yhat = zeros(T,1);
for i = 1:T
    probs = p_y; % This will be the probability for each class
    for j = 1:D
        if Xtest(i,j) == 1
            for c = 1:model.C
                probs(c) = probs(c)*p_xy(j,1,c);
            end
        else
            for c = 1:model.C
                probs(c) = probs(c)*p_xy(j,2,c);
            end
        end
    end
    [maxProb,yhat(i)] = max(probs);
end
end