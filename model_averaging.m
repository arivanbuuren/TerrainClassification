clc;clear;

%Load prediction data
load('NeuralNet code/prediction.mat')
yhat_NN = yhat;
pyx_NN = pyx;

load('predictionGMM.mat');
yhat_GMM = yhat;
pyx_GMM = pyx; 

load('predictionDecisionTree.mat')
yhat_DT = yhat;
pyx_DT = zeros(length(yhat_DT), 7);
for i = 1:length(yhat_DT)
    pyx_DT(i,yhat_DT(i)) = 1;
end
%Load true labels
load('testingData.mat')
yhat_true = yhat;

