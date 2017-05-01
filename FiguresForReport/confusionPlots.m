clear;clc;
load('../Data&Results_withoutIx/testingData.mat')
load('../Data&Results_withoutIx/trainingData.mat')

load('../Data&Results_withoutIx/predictionGMM.mat')
load('../Data&Results_withoutIx/prediction_woIx.mat')
load('../Data&Results_withoutIx/predictionDT.mat')
load('../Data&Results_withoutIx/averagePredictions.mat')
yhat_test_DT = yhat;

one_hot_labels = zeros(length(ytest),7);
GMM_hot_labels = zeros(length(ytest),7);
NN_hot_labels = zeros(length(ytest),7);
DT_hot_labels = zeros(length(ytest),7);
avg_hot_labels = zeros(length(ytest),7);
base_avg_hot_labels = zeros(length(ytest),7);
for i = 1:length(ytest)
   if(ytest(i) == 8)
       ytest(i) = 1;
   end
   one_hot_labels(i,ytest(i)) = 1;
   GMM_hot_labels(i,yhat_test_GMM(i)) = 1;
   NN_hot_labels(i,yhat_test_NN(i)) = 1;
   DT_hot_labels(i,yhat_test_DT(i)) = 1;
   avg_hot_labels(i,yavg(i)) = 1;
   base_avg_hot_labels(i,yavg_base(i)) = 1;
  
end
t = one_hot_labels';
y_GMM = GMM_hot_labels';
y_NN = NN_hot_labels';
y_DT = DT_hot_labels';
y_avg = avg_hot_labels';
y_base = base_avg_hot_labels';

figure(1)
plotconfusion(t,y_GMM,'GMM')

figure(2)
plotconfusion(t,y_NN,'Neural Net')

figure(3)
plotconfusion(t,y_DT,'Decision Tree')

figure(4)
plotconfusion(t,y_avg,'Model averaging')

figure(5)
plotconfusion(t,y_base,'Model averaging using mode')
% In case we want confusion matrices for training data
% NN_hot_train = zeros(length(ytrain), 7);
% train_hot_labels = zeros(length(ytrain),7);
% for i = 1:length(ytrain)
%    if(ytrain(i) == 8)
%        ytrain(i) = 1;
%    end
%    train_hot_labels(i,ytrain(i)) = 1;
%    NN_hot_train(i,yhat_train_NN(i)) = 1;
% end
% 

