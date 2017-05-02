clear;clc;
load('../BestDataset/testingData.mat')
load('../BestDataset/trainingData.mat')

load('../GMMCode/predictionGMMwo.mat')
load('../NeuralNet code/prediction_wo_NN.mat')
load('../DTcode/predictionDTwo.mat')
load('../RandomForest/predictionRFwo.mat')
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
% plotroc( y_true, y_NN, 'Neural Net');
% plotroc( y_true, y_GMM, 'GMM');
% plotroc( y_true, y_RF, 'Random Forest');
plotroc( y_true, y_DT, 'Decision Tree Net');

axisdata = get(gca,'userdata')
legend('Location', 'southeast')
legend(axisdata.lines,'Grass', 'Road', 'Edge', 'Soil', 'Bushes', 'Tree', 'Post')
