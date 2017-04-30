load 'ytrain_predictGMM.mat';
load 'trainingData.mat';
ytrain_prediction = ytrain_predictGMM;

%%
% Check the accuracy of grass
indices_grass = find(ytrain == 1);
[sum_grass, ~] = size(indices_grass);
[num_grass, ~] = size(find(ytrain_prediction(indices_grass) == 1));
acc_grass = num_grass/sum_grass;
fprintf('The accuracy for grass is %.4f\n', acc_grass);
% Check the accuracy of road
indices_road = find(ytrain == 2);
[sum_road, ~] = size(indices_road);
[num_road, ~] = size(find(ytrain_prediction(indices_road) == 2));
acc_road = num_road/sum_road;
fprintf('The accuracy for road is %.4f\n', acc_road);
% Check the accuracy of sidewalk
indices_sidewalk = find(ytrain == 3);
[sum_sidewalk, ~] = size(indices_sidewalk);
[num_sidewalk, ~] = size(find(ytrain_prediction(indices_sidewalk) == 3));
acc_sidewalk = num_sidewalk/sum_sidewalk;
fprintf('The accuracy for sidewalk is %.4f\n', acc_sidewalk);
% Check the accuracy of dirt
indices_dirt = find(ytrain == 4);
[sum_dirt, ~] = size(indices_dirt);
[num_dirt, ~] = size(find(ytrain_prediction(indices_dirt) == 4));
acc_dirt = num_dirt/sum_dirt;
fprintf('The accuracy for dirt is %.4f\n', acc_dirt);
% Check the accuracy of bushes
indices_bushes = find(ytrain == 5);
[sum_bushes, ~] = size(indices_bushes);
[num_bushes, ~] = size(find(ytrain_prediction(indices_bushes) == 5));
acc_bushes = num_bushes/sum_bushes;
fprintf('The accuracy for bushes is %.4f\n', acc_bushes);
% Check the accuracy of tree
indices_tree = find(ytrain == 6);
[sum_tree, ~] = size(indices_tree);
[num_tree, ~] = size(find(ytrain_prediction(indices_tree) == 6));
acc_tree = num_tree/sum_tree;
fprintf('The accuracy for tree is %.4f\n', acc_tree);
% Check the accuracy of post
indices_post = find(ytrain == 7);
[sum_post, ~] = size(indices_post);
[num_post, ~] = size(find(ytrain_prediction(indices_post) == 7));
acc_post = num_post/sum_post;
fprintf('The accuracy for post is %.4f\n', acc_post);




