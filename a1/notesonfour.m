[N,D] = size(X);

% Computer number of class lables
C = max(y);


for j=1:D
    for c=1:C
        indexc = find(y==c);
        p_xy(j,1,c) = sum(X(indexc,j))/ length(indexc)
        p_xy(j,2,c) = 1 -  p_xy(j,1,c);
    end
end
