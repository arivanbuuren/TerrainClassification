load 'trainingData.mat';

load 'predictionGMM.mat';
ypredict_GMM = yhat_train_GMM;
fprintf('Accuracy for GMM is %.4f\n', mean(ytrain == ypredict_GMM));
load 'NeuralNet code/prediction.mat';
ypredict_NN = yhat_train_NN;
fprintf('Accuracy for NN is %.4f\n', mean(ytrain == ypredict_NN));
load 'prediction_DT/ytrain_prediction.mat';
ypredict_DT = ytrain_prediction;
fprintf('Accuracy for Decision Tree is %.4f\n', mean(ytrain == ypredict_DT));

load 'acc.mat'

[n, ~] = size(ytrain);
yhat = zeros(n, 1);

for i = 1:n
    if ypredict_GMM(i) == 8
        ypredict_GMM(i) = 2;
    end
%     acc_temp = [acc(1, ypredict_NN(i)) acc(2, ypredict_GMM(i)) acc(3, ypredict_DT(i))];
%     [v, ind] = max(acc_temp);
%     if ind == 1
%         yhat(i) = ypredict_NN(i);
%     elseif ind == 2
%         yhat(i) = ypredict_GMM(i);
%     else
%         yhat(i) = ypredict_DT(i);
%     end
end

fprintf('Accuracy after averaging is %.4f\n', mean(yhat == ytrain));
    