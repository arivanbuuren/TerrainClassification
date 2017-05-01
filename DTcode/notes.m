%clear
% clc
load('C:\Users\HP\Documents\Graduate School\Machine Learning\Assignment 1\a1\fluTrends.mat')
[n,d] = size(X);
%1.1  Summary Statistics %
min_value = min(X(:))
max_value = max(X(:))
mean_value = mean(X(:))
mode_value = mode(X(:))
quantile_vector = quantile(X(:),[0.1,0.25,0.5,0.75,0.90])

%% find highest and lowest 
    mean_per_region = mean ( X,1 ) ;
    var_per_region = var( X );
    R = corrcoef(X);

 highest_mean = names( find(mean_per_region == max(mean_per_region)) )
 lowest_mean = names( find(mean_per_region == min(mean_per_region)) )
 highest_var = names( find(var_per_region == max( var_per_region )) )
 lowest_var = names( find(var_per_region == min( var_per_region )) )

%% plots
plot (X,'LineWidth',1.5);
title('Weeks vs influenza-like illnes percentages per region')
xlabel('Weeks [n]')
ylabel('Percentage [%]')
axis([0 52 0 5])
grid on
legend(names)
box on
%%
 figure(2)
boxplot(X')
title('Distribution across regions for each week')
xlabel('Week')
ylabel('Distribution across regions')
grid on
print -dpdf boxplot

%%
 figure(3)
hist (X)
grid on
legend(names)
title('Distribution of all the regions in X')
xlabel('Percentage of influenza-like illness [%]')
ylabel('Count per region')

 figure(4)
vector_x = reshape(X,n*d,1);
hist(vector_x)
title('Distribution of all the values in the matrix X')
xlabel('Percentage of influenza-like illness [%]')
ylabel('Total count')
grid on


 figure(5)
line_corr = linspace(0,3,4);
scatter(X(:,2), X(:,3), 'filled')
hold on
plot(line_corr, line_corr, 'r')
title('Highest Correlation between two regions')
xlabel('MidAlt')
ylabel('ENCentral')
grid on
box on
hold off

figure(6)
scatter(X(:,1), X(:,8), 'filled')
hold on
plot(line_corr, line_corr, 'r')
title('Lowest correlation between two regions')
xlabel('NE')
ylabel('Mtn')
grid on
box on
hold off