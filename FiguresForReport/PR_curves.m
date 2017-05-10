clear;clc;
load('../p&r.mat')

load('../BestDataset/testingData.mat')


load('../GMMCode/predictionGMMwo.mat')
load('../NeuralNet code/prediction_wo_NN.mat')
load('../DTcode/predictionDTwo.mat')
load('../RandomForest/predictionRFwo.mat')

%Need per class P-R
y_grass = find(ytest == 1); 
[XprGMM,YprGMM,Tpr,AUCpr] = perfcurve(ytest, yhat_test_GMM, 1, 'xCrit', 'reca', 'yCrit', 'prec');
[XprDT,YprDT,Tpr,AUCpr] = perfcurve(ytest, yhat_test_DT, 1, 'xCrit', 'reca', 'yCrit', 'prec');
[XprNN,YprNN,Tpr,AUCpr] = perfcurve(ytest, double(yhat_test_NN), 1, 'xCrit', 'reca', 'yCrit', 'prec');
[XprRF,YprRF,Tpr,AUCpr] = perfcurve(ytest, yhat_test_RF, 1, 'xCrit', 'reca', 'yCrit', 'prec');
plot(XprGMM,YprGMM, XprDT, YprDT, XprNN, YprNN, XprRF, YprRF)
xlabel('Recall'); ylabel('Precision')
