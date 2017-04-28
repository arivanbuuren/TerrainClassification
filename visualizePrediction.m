function [ predImage ] = visualizePrediction( yhat )
%Function to show image segmentation and classification
grass = [0, 200, 0];
road = [100, 100, 100];
sidewalk = [255, 255, 0];
dirt = [160,80,45];
bushes = [220,160,32];
tree = [0, 0, 0];
post = [0, 77, 153];

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
            case(3)
                predImage(i,j,:) = sidewalk;
            case(4)
                predImage(i,j,:) = dirt;
            case(5)
                predImage(i,j,:) = bushes;
            case(6) 
                predImage(i,j,:) = tree;
            case(7)
                predImage(i,j,:) = post;
            otherwise
                im(i,j)
        end
    end
end
predImage = predImage / 255;
imshow(predImage);
end

