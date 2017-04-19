close all;
clear;

load '/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/labels/label_image1.mat'

num = 1;
filename = strcat('/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/cleanSegments/image', int2str(num), '.ppm');
I = imread(filename);

Xtrain = double(Xtrain);
model = generativeGaussian(Xtrain, ytrain);
yhat = model.predict(model, Xtrain);
fprintf('Gaussian Gen. Model. accuracy is %.2f\n', mean(yhat == ytrain));