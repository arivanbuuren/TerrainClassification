function Ix = horizontalDerivative(X, sigma)

% Calculating the horizontal Derivative of an image
% The image is blurred by a 2D Gaussian filter with sigma
% Pad the edge with zeros
X = im2double(X);
X = rgb2gray(X);
X = imgaussfilt(X, sigma);
[n, d] = size(X);
Ix = zeros(n, d);

for i = 1:(d-1)
    Ix(:, i) = X(:, i+1) - X(:, i);
end

end

