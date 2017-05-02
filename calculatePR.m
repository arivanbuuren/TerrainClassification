load 'BestDataset/testingData.mat'

load 'NeuralNet code/prediction_wo_NN.mat'
yhat_NN_wo = double(yhat_test_NN);

load 'NeuralNet code/prediction_with_NN.mat'
yhat_NN_w = double(yhat_test_NN);

load 'GMMcode/predictionGMMwo.mat'
yhat_GMM_wo = double(yhat_test_GMM);

load 'GMMcode/predictionGMMwith.mat'
yhat_GMM_w = double(yhat_test_GMM);

load 'DTcode/predictionDTwo.mat'
yhat_DT_wo = double(yhat_test_DT);

load 'DTcode/predictionDT.mat'
yhat_DT_w = double(yhat);

load 'RandomForest/predictionRFwo.mat'
yhat_RF_wo = double(yhat_test_RF);

load 'RandomForest/predictionRFwith.mat'
yhat_RF_w = double(yhat_test_RF);

[NN_wo] = calculate(ytest, yhat_NN_wo);
[NN_w] = calculate(ytest, yhat_NN_w);
[GMM_wo] = calculate(ytest, yhat_GMM_wo);
[GMM_w] = calculate(ytest, yhat_GMM_w);
[DT_wo] = calculate(ytest, yhat_DT_wo);
[DT_w] = calculate(ytest, yhat_DT_w);
[RF_wo] = calculate(ytest, yhat_RF_wo);
[RF_w] = calculate(ytest, yhat_RF_w);

result = [NN_wo; NN_w; GMM_wo; GMM_w; DT_wo; DT_w; RF_wo; RF_w];

p_w = [NN_w(1, :); GMM_w(1, :); RF_w(1, :); DT_w(1, :)];
p_w = p_w(:, 1:7);
r_w = [NN_w(2, :); GMM_w(2, :); RF_w(2, :); DT_w(2, :)];
r_w = r_w(:, 1:7);
p_wo = [NN_wo(1, :); GMM_wo(1, :); RF_wo(1, :); DT_wo(1, :)];
p_wo = p_wo(:, 1:7);
r_wo = [NN_wo(2, :); GMM_wo(2, :); RF_wo(2, :); DT_wo(2, :)];
r_wo = r_wo(:, 1:7);

save('p&r.mat', 'p_w', 'r_w', 'p_wo', 'r_wo');





