clear all
load newsgroups.mat

[N,D] = size(X);
T = length(yvalidate);

% Compute validation error with decision tree
% depth = 20;
% model = decisionTree(X,y,depth);
% % set yhat
% yhat = model.predict(model,Xvalidate);
% errorValidate = sum(yhat ~= yvalidate)/T;
% fprintf('Validation error with decision tree: %.2f\n',errorValidate);

% Compute validation error with naive Bayes
model = naiveBayes(X,y);
yhat = model.predict(model,Xvalidate);
errorValidate = sum(yhat ~= yvalidate)/T;
fprintf('Validation error with naive Bayes: %.2f\n',errorValidate);