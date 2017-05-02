clear;clc;
load('../BestDataset/testingData.mat')
load('../BestDataset/trainingData.mat')

load('../GMMCode/predictionGMMwith.mat')
load('../NeuralNet code/prediction_with_NN.mat')
load('../DTcode/predictionDTwith.mat')
load('../RandomForest/predictionRFwith.mat')
% load('../ModelAveraging/averagePredictions.mat')
%Remove Ix and Iy from training data


[t,~] = size(Xtest);
num_classes = 7;
y_true = zeros(num_classes, t);
y_GMM = zeros(num_classes, t);
y_NN = zeros(num_classes, t);
y_DT = zeros(num_classes, t);
y_RF = zeros(num_classes, t);
% avg_hot_labels = zeros(length(ytest),7);
% base_avg_hot_labels = zeros(length(ytest),7);
for i = 1:t
   %Assign missclassifications to class 1
   if(ytest(i) == 8)
       ytest(i) = 1;
   end
   
   y_true(ytest(i), i) = 1;
   y_GMM(yhat_test_GMM(i), i) = 1;
   y_NN(yhat_test_NN(i), i) = 1;
   y_DT(yhat_test_DT(i), i) = 1;
   y_RF(yhat_test_RF(i), i) = 1;
%    avg_hot_labels(i,yavg(i)) = 1;
%    base_avg_hot_labels(i,yavg_base(i)) = 1;
end

figure(1)
plotconfusion(y_true,y_GMM,'GMM')

% figure(2)
% plotconfusion(y_true,y_NN,'Neural Net')
% 
% figure(3)
% plotconfusion(y_true,y_DT,'Decision Tree')
% 
% figure(4)
% plotconfusion(y_true, y_RF, 'Random Forest')

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
set(gca,'xticklabel',{'Grass' 'Road' 'Edge' 'Soil' 'Bushes' 'Tree' 'Post' ' '})
set(gca,'yticklabel',{'Grass' 'Road' 'Edge' 'Soil' 'Bushes' 'Tree' 'Post' ' '})
