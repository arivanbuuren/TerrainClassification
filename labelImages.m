num = 1;
filename = strcat('/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/cleanSegments/image', int2str(num), '.ppm');
I = imread(filename);
[n, d, ~] = size(I);

grass = [0 200 0];
road = [100 100 100];
sidewalk = [0 255 255];
dirt = [45 80 160];
bushes = [32 160 220];

label = zeros(n, d);

for i = 1:n
    for j = 1:d
        if all(I(i, j, :) == grass)
            label(i, j) = 1;
        elseif all(I(i, j, :) == road)
            label(i, j) = 2;
        elseif all(I(i, j, :) == sidewalk)
            label(i, j) = 3;
        elseif all(I(i, j, :) == dirt)
            label(i, j) = 4;
        elseif all(I(i, j, :) == bushes)
            label(i, j) = 5;
        else
            label(i, j) = 6;
        end
    end
end

%Xtrain = reshape(I, [n*d, 3]);
ytrain = reshape(label, [n*d, 1]);

savefilename = strcat('/Users/CandiceTian/Desktop/WinterTerm2/540/project/TerrainClassification/labels/label_image', int2str(num), '.mat');
save(savefilename, 'ytrain');