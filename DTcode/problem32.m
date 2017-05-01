% Load X and y variable
load citiesSmall.mat
[N,D] = size(X);
Xtest = X (floor(N/2) + 1 :N  , : );
ytest= y (floor(N/2) +1 : N) ;
X =  X ( 1:floor(N/2) , : )  ;
y = y (1: floor(N/2));
mindepth = -1 ; minError = Inf;
for depth =1 :15
    errorTrain = 0; errorTest = 0; 
    for i =1:2 
        [N,D] = size(X);
        T = length(ytest);
        model = decisionTreeInfoGain(X,y,depth);
        yhat = model.predict(model,X);
        errorTrain = errorTrain +sum(yhat ~= y)/N;
        yhat = model.predict(model,Xtest);
        errorTest = errorTest + sum(yhat ~= ytest)/T;
        [X, Xtest]=mySwap(Xtest, X); 
        [y,ytest] = mySwap(ytest,y) ;
    end
    disp(errorTest/2 ) ;     
    if errorTest/2 < minError 
        minError= errorTest/2; 
        mindepth = depth;
    end
end 
disp(minError); disp(mindepth); 


