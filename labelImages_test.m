ytest = [];
Xtest = [];
for num = 31:40
    filename = strcat('labeledImages/image', int2str(num), '.ppm');
    filename1 = strcat('originalImages/image', int2str(num), '.ppm');
    I = imread(filename);
    I1 = imread(filename1);
    [n, d, ~] = size(I);

    grass = 200;
    road = 100;
    sidewalk = 255;
    dirt = 80;
    bushes = 160;

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
            else
                label(i, j) = 6;
            end
        end
    end
    label = reshape(label, [n*d, 1]);
    ytest = [ytest; label];
    I1 = reshape(I1, [n*d, 3]);
    Xtest = [Xtest; I1];
end

Xtest = double(Xtest);
%Xtest = rgb2lab(Xtest);

%savefilename = strcat('/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/labels/label_image', int2str(num), '.mat');
save('testingData', 'Xtest', 'ytest');
%save(savefilename, 'ytest');