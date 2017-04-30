filename = 'originalImages/image1.png';
I = imread(filename);
[features, vis] = extractHOGFeatures(I, 'CellSize', [60 60]);
plot(vis);