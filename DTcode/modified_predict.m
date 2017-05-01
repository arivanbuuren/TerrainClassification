function [y] = predict(model,X)
[t,d] = size(X);
y = zeros(t,1);

for i = 1:t
    if ( X(i,2) > 37.6690 )
        if ( X(i,1) > -96.0901)
            y(i) = 1;
        else
            y(i) = 2;
        end
    else 
        if ( X(i,1) > -115.5776 ) 
            y(i) = 2;
        else
            y(i) = 1;
        end
    end
end

end