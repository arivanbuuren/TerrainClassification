function [ conditionals ] = get_conditional( num_classes, yhat, y )
%get_conditional(num_classes, yhat, y)
%   computes conditional probability table

conditionals = zeros(num_classes);
for true_k = 1:num_classes
    ind_true_k = find(y == true_k); 
    for pred_k = 1:num_classes
        conditionals(pred_k, true_k) = sum(yhat(ind_true_k) == pred_k) / length(ind_true_k);
    end
end

end

