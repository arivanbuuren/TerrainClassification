clear;
% load('yhat.mat');
load('NeuralNet code/prediction.mat');
yhat = yhat_test_NN;
im_w = 120;
im_h = 160;
numImages =  length(yhat) / (im_w * im_h) ; 
predictions = reshape(yhat, [im_w*im_h,numImages]); 

for im = 1:numImages
   yvis = visualizePrediction(predictions(:,im));
   imName = char(strcat('classifiedImages/NNet/image', string(im), '.png' ));
   imwrite(yvis, imName);
end
