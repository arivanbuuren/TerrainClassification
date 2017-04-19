function [ model ] = generativeGaussianSSL( X, y, Xtilde )

% Fits a GDA model on labeled dataset X
k = numel(unique(y));
model_init = generativeGaussian(X, y);
mu = model_init.mu;
sigma = model_init.sigma;
theta = model_init.theta;
yhat = model_init.predict(model_init, Xtilde);

[t, d] = size(Xtilde);
yhat_0 = zeros(t, 1);
r = zeros(t, k);

nc = zeros(k,1);
for c = 1:k
    nc(c) = sum(y == c);
end

mu_a = zeros(k, d);
for c = 1:k
    mu_a(c, :) = sum(X(y==c, :));
    indices = find(y == c);
    s_a{c} = zeros(d);
    for i = 1:nc(c)
        xi = X(indices(i),:)'; 
        s_a{c} = s_a{c} + (xi-mu(:,c))*(xi-mu(:,c))';
    end
end

count = 0;
% EM Algorithm
while ( mean(yhat == yhat_0) ~= 1 )  % Stop if predictions on Xtilde stop changing
    yhat_0 = yhat;
    y_con = [y; yhat_0];
    for c=1:k
        theta(c) = sum(y_con == c) / length(y_con);
    end
    
    % E-step: Compute r_c for all the unlabeled examples based on the
    % current sigma and mu
    for i = 1:t
        xi = Xtilde(i,:)';
        for c = 1:k
            mu_c = mu(:,c);
            theta_c = theta(c);
            px = (1 / sqrt((2*pi)^d * det(sigma{c}))) * exp( -0.5 * (xi-mu_c)' * inv(sigma{c}) * (xi-mu_c) );
            r(i, c) = px * theta_c; 
        end
    end
    % Normalize each row of r
    for i = 1:t
        r(i, :) = r(i, :)/sum(r(i, :));
    end
     
    % M-step: Update sigma and mu based on the current complete data
    for c = 1:k
        factor = nc(c) + sum(r(:, c));
        % Compute mu_c
        X_temp = Xtilde;
        for i = 1:t
            X_temp(i, :) = r(i, c) * Xtilde(i, :);
        end
        mu_b = sum(X_temp, 1);
        mu(:, c) = (mu_a(c, :) + mu_b)/factor;
        % Compute sigma_c
        s_b = zeros(d);
        for i = 1:t
            xi = Xtilde(i, :)';
            s_b = s_b + r(i, c) * (xi - mu(:,c)) * (xi - mu(:,c))';
        end
        sigma{c} = (s_a{c} + s_b)/factor;
    end
    
    % Use the current sigma and mu to predict on Xtilde
    for i = 1:t
        xi = Xtilde(i,:)';
        for c = 1:k
            mu_c = mu(:,c);
            theta_c = theta(c);
            pxc(c) = (1 / sqrt((2*pi)^d * det(sigma{c}))) * exp( -0.5 * (xi-mu_c)' * inv(sigma{c}) * (xi-mu_c) );
            pyc(c) = pxc(c) * theta_c; 
        end
        [~, yhat(i)] = max(pyc);
    end
    count = count+1
       

end


model.mu = mu;
model.sigma = sigma;
model.theta = theta;
model.predict = @(model, Xtest) predict(model, Xtest);

     
end


function yhat = predict(model, X )
 [n,d] = size(X);
 sigma = model.sigma;
 mu = model.mu;
 theta = model. theta; 
 
 [k, ~] = size(model.theta);
 yhat = zeros(n,1);
 for i=1:n
     xi = X(i,:)';
    for c = 1:k
        mu_c = mu(:,c);
        theta_c = theta(c);
        px(c) = (1 / sqrt((2*pi)^d * det(sigma{c}))) * exp( -0.5 * (xi-mu_c)' * inv(sigma{c}) * (xi-mu_c) );
        pyc(c) = px(c) * theta_c; 
    end
    [~, yhat(i)] = max(pyc);
 end
end





