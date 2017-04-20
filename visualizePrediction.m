function [ predImage ] = visualizePrediction( yhat )
%Function to show image segmentation and classification
grass = [0, 200, 0];
road = [100, 255, 100];
sidewalk = [255, 255, 0];
dirt = [160,80,45];
bushes = [220,160,32];


row = 120;
col = 160;
predImage = zeros(row, col, 3);

im = reshape(yhat,[row, col]);
for i = 1:row
    for j = 1:col
        switch(im(i,j))
            case(1)
                predImage(i,j,:) = grass;
            case(2) 
                predImage(i,j,:) = road;
                fprintf('road\n');
            case(3)
                predImage(i,j,:) = sidewalk;
            case(4)
                predImage(i,j,:) = dirt;
            case(5)
                predImage(i,j,:) = bushes;
            otherwise
                im(i,j)
        end
    end
end

end

