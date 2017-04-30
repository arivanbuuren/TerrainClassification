function [model] = logisticL2(X,y,lambda)

% Add bias variable
[n,d] = size(X);
X = [ones(n,1) X];

% Initial values of regression parameters
w = zeros(d+1,1);

% Solve logistic regression problem
options = [];
options.optTol = 1e-2;
options.Display = 'none';
w = minFunc(@objective,w,options,X,y,lambda);

model.w = w;
model.predict = @predict;
model.sample = @sample;
end

function [yhat] = predict(model,Xhat)
[t,d] = size(Xhat);
Xhat = [ones(t,1) Xhat];
w = model.w;
yhat = sign(Xhat*w);
end

function [ysample] = sample(model,xhat)
p_y = 1/(1 + exp(-[1 xhat]*model.w));
if rand < p_y
    ysample = 1;
else
    ysample = -1;
end
end

function [nll,g,H] = objective(w,X,y,lambda)
%yXw = y.*(X*w);
Z = 1+exp(-y.*(X*w));

% Function value
%nll = sum(log(1+exp(-yXw))) + (lambda/2)*(w'*w)
nll = sum(log(Z)) + (lambda/2)*(w'*w);

% Gradient
%sigmoid = 1./(1+exp(-yXw));
sigmoid = 1./Z;
g = -(X'*(y.*(1-sigmoid))) + lambda*w;
end

function [Hv] = Hvfunc(w,v,X,y,lambda)
yXw = y.*(X*w);
sigmoid = 1./(1+exp(-yXw));
Hv = X'*(diag(sparse(sigmoid.*(1-sigmoid)))*(X*v)) + lambda*v;
end