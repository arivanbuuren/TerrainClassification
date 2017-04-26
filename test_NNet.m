clear;
load('prediction.mat');
l = 120*160;
yvis = yhat(l:l,:);
visualizePrediction(yvis);