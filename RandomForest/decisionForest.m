function [model] = decisionForest(X,y,depth,nBootstraps)
[n,d] = size(X);
% Fit model to each boostrap sample of data
for m = 1:nBootstraps
%     fprintf('creating bootstrap X of n samples\n');
    %Create a bootstrap X of n samples
    for i = 1:n/50
        j = ceil(n*rand()); % Pick a number from 1 to n
        Xbst(i,:) = X(j,:);
        ybst(i,1) = y(j);
    end
%       fprintf('fitting randomtree\n');
      model.subModel{m} = randomTree(Xbst,ybst,depth); %for 2.2.4
end

model.predict = @predict;

end

function [y] = predict(model,X)

% Predict using each model
for m = 1:length(model.subModel)
    y(:,m) = model.subModel{m}.predict(model.subModel{m},X);
end

% Take the most common label
y = mode(y,2);
end