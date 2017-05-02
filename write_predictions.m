clear;
load('ModelAveraging/averagePredictionswith.mat');
yhat = yavg_base;
im_w = 120;
im_h = 160;
numImages =  length(yhat) / (im_w * im_h) ; 
predictions = reshape(yhat, [im_w*im_h,numImages]); 

for im = 1:numImages
   yvis = visualizePrediction(predictions(:,im));
   imName = char(strcat('classifiedImages/with_IxIy/BaseAvg/image', string(im), '.png' ));
   imwrite(yvis, imName);
end
