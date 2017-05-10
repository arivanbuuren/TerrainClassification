clear;clc;
load('../BestDataset/testingData.mat')
load('../BestDataset/trainingData.mat')

load('../GMMCode/predictionGMMwith.mat')
load('../NeuralNet code/prediction_with_NN.mat')
load('../DTcode/predictionDTwith.mat')
load('../RandomForest/predictionRFwith.mat')

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
p = plotroc( y_true, pyx_test_NN', 'Neural Net');
% plotroc( y_true, pyx_test_GMM', 'GMM');
% plotroc( y_true, y_RF, 'Random Forest');
% plotroc( y_true, y_DT, 'Decision Tree');

axisdata = get(gca,'userdata')
legend('Location', 'southeast')
legend(axisdata.lines,'Grass', 'Road', 'Edge', 'Soil', 'Bushes', 'Tree', 'Post')
% set(gca,'fontsize',29);
% % set(gca,'XTick', [0 0.25 0.5 0.75 1])
%  h_plot = get(gca,'Children');
% % NameArray = {'LineStyle'};
% % ValueArray = {'-','--',':','-.','^','*','.'}';
% % set(p,NameArray,ValueArray)