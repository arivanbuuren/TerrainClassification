clc;clear;
num_classes = 7;
%Load train data
load('../BestDataset/trainingData.mat');

%Load prediction data for NN
load('../NeuralNet code/prediction_with_NN.mat')

%Load prediction data for DT
load('../DTcode/predictionDTwith')

%Load prediction data for RF
load('../RandomForest/predictionRFwith.mat')

%Load prediction data for GMM
load('../GMMcode/predictionGMMwith.mat')

%Load test data
load('../BestDataset/testingData.mat')

%Conditionals NN
conditionals_NN = get_conditional(num_classes, yhat_train_NN, ytrain);
conditionals_GMM = get_conditional(num_classes, yhat_train_GMM, ytrain);
conditionals_RF = get_conditional(num_classes, yhat_train_RF, ytrain);
conditionals_DT = get_conditional(num_classes, yhat_train_DT, ytrain);

%% Average predictions
[t,d] = size(ytest);
yavg = zeros(t,1);
yavg_base = zeros(t,1);
ys = [yhat_test_NN, yhat_test_GMM, yhat_test_RF, yhat_test_DT];
yavg_base = mode(ys,2);

for i = 1:t
    if (ys(i,1) == ys(i,2) && ys(i,1) == ys(i,3) && ys(i,1) == ys(i,4))
        yavg(i) = ys(i,1);
       
    else
        NN_cond = conditionals_NN(ys(1),ys(1));
        GMM_cond = conditionals_GMM(ys(2),ys(2));
        RF_cond = conditionals_RF(ys(3), ys(3));
        DT_cond = conditionals_DT(ys(4),ys(4));
        [~,b] = max([NN_cond,GMM_cond,RF_cond,DT_cond]);
        yavg(i) = ys(b);  
    end
end

fprintf('Accuracy of NN:  %.4f\n', mean(yhat_test_NN==ytest));
fprintf('Accuracy of GMM: %.4f\n', mean(yhat_test_GMM == ytest));
fprintf('Accuracy of RF:  %.4f\n', mean(yhat_test_RF == ytest));
fprintf('Accuracy of DT:  %.4f\n', mean(yhat_test_DT == ytest));
fprintf('Accuracy of Avg: %.4f\n', mean(yavg == ytest));
fprintf('Accuracy of Bse: %.4f\n', mean(yavg_base == ytest));

save('averagePredictionswith.mat', 'yavg', 'yavg_base');
