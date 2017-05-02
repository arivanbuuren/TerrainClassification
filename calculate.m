function [ result ] = calculate( y, yhat )
% Calculate precision and recall rate
% First row is precision, second row is recall rate

CM = confusionmat(y, yhat);

precision = diag(CM)./sum(CM, 2);
recall = diag(CM)./sum(CM, 1)';
result = [precision'; recall'];


end

