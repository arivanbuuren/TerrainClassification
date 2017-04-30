load 'acc_NN.mat'
load 'acc_GMM.mat'
load 'acc_DT.mat'

acc = [acc_NN; acc_GMM; acc_DT];

save('acc.mat', 'acc');