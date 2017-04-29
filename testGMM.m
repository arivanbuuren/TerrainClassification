close all;
clear;

addLabels(0.5, 1, 83);

load 'Data.mat'

sizeImage = 120*160;
Xtrain = X(1:sizeImage*75, :);
ytrain = y(1:sizeImage*75);
Xtest = X(sizeImage*75+1:sizeImage*83, :);
ytest = y(sizeImage*75+1:sizeImage*83);


model = generativeGaussian(Xtrain, ytrain);
yhat = model.predict(model, Xtest);
fprintf('Gaussian Gen. Model. accuracy is %.2f\n', mean(yhat == ytest));%