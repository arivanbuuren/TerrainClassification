figure(1)
plot(errorTrain, 'b', 'linewidth', 2);
hold on;
plot(errorTest, 'r', 'linewidth', 2);
grid on;
legend('Train error', 'Test error');
box on;
xlabel('Depth');
ylabel('Error');
title('Training and testing error varying depth from 1 to 15');
hold off;
