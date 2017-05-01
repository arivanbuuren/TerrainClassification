% Load X and y variable
load citiesSmall.mat
[n,d] = size(X);

% Plot data
plot(X(y==1,1),X(y==1,2),'b+');hold on;
plot(X(y==2,1),X(y==2,2),'ro');

%% Fit majority predictor and compute error
model = majorityPredictor(X,y);

% Evaluate training error
yhat = model.predict(model,X);
error = sum(yhat ~= y)/n;
fprintf('Error with majority predictor: %.2f\n',error);

%% Fit decision stump and compute error
model = decisionStumpEquality(X,y);

% Evaluate training error
yhat = model.predict(model,X);
error = sum(yhat ~= y)/n;
fprintf('Error with equality-rule decision stump: %.2f\n',error);

% Plot classifier
figure(2);
classifier2Dplot(X,y,model);


%% Fit decision stump with inequalities and compute error by Ariadna
model = decisionStump(X,y);

%Evaluate training error
yhat = model.predict(model,X);
error = sum(yhat ~= y)/n;
fprintf('Error with inequality-rule decision stump: %.2f\n',error);

%Plot classifier 
figure(3);
classifier2Dplot(X,y,model);
