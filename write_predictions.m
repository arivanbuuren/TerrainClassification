clear;
% load('yhat.mat');
% load('Data&Results_withoutIx/prediction_woIx.mat');
% load('Data&Results_withoutIx/testingData.mat');
% load('predictionDT/yhat.mat')
% load('Data&Results_withoutIx/predictionGMM.mat');
% load('ignoreThis/testingData.mat')
% load('ignoreThis/predictionGMMwo.mat');
load('ignoreThis/prediction_IxIy.mat');
yhat = yhat_test_NN;
im_w = 120;
im_h = 160;
numImages =  length(yhat) / (im_w * im_h) ; 
predictions = reshape(yhat, [im_w*im_h,numImages]); 

for im = 1:numImages
   yvis = visualizePrediction(predictions(:,im));
   imName = char(strcat('classifiedImages/IxIy/NNet/image', string(im), '.png' ));
   imwrite(yvis, imName);
end
