clear;
% load('yhat.mat');
% load('Data&Results_withoutIx/prediction_woIx.mat');
% load('Data&Results_withoutIx/testingData.mat');
% load('predictionDT/yhat.mat')
load('Data&Results_withoutIx/predictionGMM.mat');
yhat = yhat_test_GMM;
im_w = 120;
im_h = 160;
numImages =  length(yhat) / (im_w * im_h) ; 
predictions = reshape(yhat, [im_w*im_h,numImages]); 

for im = 1:numImages
   yvis = visualizePrediction(predictions(:,im));
   imName = char(strcat('classifiedImages/noIx/GMM/image', string(im), '.png' ));
   imwrite(yvis, imName);
end
