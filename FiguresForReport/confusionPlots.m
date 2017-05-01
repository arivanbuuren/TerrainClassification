clear;clc;
load('../testingData.mat')
load('../predictionGMM.mat')
load('../NeuralNet code/prediction.mat')
load('../predictionDT/yhat.mat')
yhat_test_DT = yhat;

one_hot_labels = zeros(length(ytest),7);
GMM_hot_labels = zeros(length(ytest),7);
NN_hot_labels = zeros(length(ytest),7);
DT_hot_labels = zeros(length(ytest),7);
for i = 1:length(ytest)
   if(ytest(i) == 8)
       ytest(i) = 2;
   end
   one_hot_labels(i,ytest(i)) = 1;
   GMM_hot_labels(i,yhat_test_GMM(i)) = 1;
   NN_hot_labels(i,yhat_test_NN(i)) = 1;
   DT_hot_labels(i,yhat_test_DT(i)) = 1;
end

t = one_hot_labels';
y_GMM = GMM_hot_labels';
y_NN = NN_hot_labels';
y_DT = DT_hot_labels';

figure(1)
plotconfusion(t,y_GMM,'GMM')

figure(2)
plotconfusion(t,y_NN,'Neural Net')

figure(3)
plotconfusion(t,y_DT,'Decision Tree')