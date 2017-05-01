function [model] = majorityPredictor(X,y)
% Simple classifier that always predicts the most common label in the
% training set
model.y_mode = mode(y);
model.predict = @(model,X)model.y_mode*ones(size(X,1),1);
