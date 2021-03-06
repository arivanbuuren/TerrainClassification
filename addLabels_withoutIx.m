function addLabels_withoutIx(startPoint, endPoint)
    y = [];
    X = [];
    number = endPoint-startPoint+1;
    S = randperm(number);
    for num = 1:number
        filename = strcat('labeledImages/image', int2str(S(num)), '.png');
        filename1 = strcat('originalImages/image', int2str(S(num)), '.png');
        I = imread(filename);
        I1 = imread(filename1);
        [n, d, ~] = size(I);

        grass = 200;
        road = 100;
        sidewalk = 255;
        dirt = 80;
        bushes = 160;
        tree = 0;
        post = 77;

        label = zeros(n, d);

        for i = 1:n
            for j = 1:d
                if (I(i, j, 2) == grass)
                    label(i, j) = 1;
                elseif (I(i, j, 2) == road)
                    label(i, j) = 2;
                elseif (I(i, j, 2) == sidewalk)
                    label(i, j) = 3;
                elseif (I(i, j, 2) == dirt)
                    label(i, j) = 4;
                elseif (I(i, j, 2) == bushes)
                    label(i, j) = 5;
                elseif (I(i, j, 2) == tree)
                    label(i, j) = 6;
                elseif (I(i, j, 2) == post)
                    label(i, j) = 7;
                else
                    label(i, j) = 8;
                end
            end
        end
        label = reshape(label, [n*d, 1]);
        y = [y; label];
        I2 = reshape(I1, [n*d, 3]);
        X = [X; I2];
    end

    X = double(X);

    save('Data_withoutIx', 'X', 'y');

end


