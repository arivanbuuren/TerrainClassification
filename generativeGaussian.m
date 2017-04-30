function [ model ] = generativeGaussian( X, y )
%Fits a GDA model to dataset using individual full covariance matrices
[t,d] = size(X);
k = numel(unique(y));

mu = zeros(d,k);
sigma = eye(d);

%compute probabilities
nc = zeros(k,1);
theta = zeros(k,1);
for c=1:k
    nc(c) = sum(y == c);
    theta(c) = nc(c) / length(y);
    sig{c} = sigma;
end


% Update class means
% mu_c is the average along each dimension 
% each class has its own mean
for c=1:k
   mu(:,c) =  (1/nc(c)) * sum(X(y==c,:));
end

%Update covariances
for c=1:k
    indices = find(y == c);
    s = zeros(d);
    for i = 1:nc(c)
       xi = X(indices(i),:)'; 
       s = s + (xi-mu(:,c))*(xi-mu(:,c))';
    end
    sig{c} = (1/nc(c)) * s ;
end

model.mu = mu;
model.sigma = sig;
model.theta = theta;
model.predict = @(model, Xtest) predict(model, Xtest);
end

function [yhat, pyx] = predict(model, X )
 [n,d] = size(X);
 sigma = model.sigma;
 mu = model.mu;
 theta = model. theta; 
 
 [k, ~] = size(model.theta);
 yhat = zeros(n,1);
 pyx = zeros(n,k);
 for i=1:n
     xi = X(i,:)';
    for c = 1:k
        mu_c = mu(:,c);
        theta_c = theta(c);
        px(c) = (1 / sqrt((2*pi)^d * det(sigma{c}))) * exp( -0.5 * (xi-mu_c)' * inv(sigma{c}) * (xi-mu_c) );
        pyc(c) = px(c) * theta_c; 
    end
    [~, yhat(i)] = max(pyc);
    pyx(i,:) = pyc / sum(pyc);
 end
end
