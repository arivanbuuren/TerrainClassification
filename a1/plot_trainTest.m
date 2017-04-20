% Load training {X,y} and testing {Xtest,ytest} variables
load citiesSmall.mat
[n,d] = size(X);

for d = 1:15
    depth = d;
    model = decisionTreeInfoGain(X,y,depth);
    
    % Evaluate training error
    yhat = model.predict(model,X);
    errorTrain(d) = sum(yhat ~= y)/n;
%     fprintf('Training error with depth-%d decision tree: %.3f\n',depth,errorTrain);
    
    % Evaluate test error
    t = size(Xtest,1);
    yhat = model.predict(model,Xtest);
    errorTest(d) = sum(yhat ~= ytest)/t;
%     fprintf('Test error with depth-%d decision tree: %.3f\n',depth,errorTest);
end
figure(1)
plot(errorTrain, 'b', 'linewidth', 1.5);
hold on;
plot(errorTest, 'r', 'linewidth', 1.5);
grid on;
legend('Train error', 'Test error');
box on;
xlabel('Depth');
ylabel('Error');
title('Training and testing error varying depth from 1 to 15');
hold off;

