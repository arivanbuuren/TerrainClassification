function [] = plot2DClassifier(X,y,model)

increment = 500;

clf;
plot(X(y==1,1),X(y==1,2),'b+');hold on;
plot(X(y==2,1),X(y==2,2),'ro');

domain1 = xlim;
domain1 = domain1(1):(domain1(2)-domain1(1))/increment:domain1(2);
domain2 = ylim;
domain2 = domain2(1):(domain2(2)-domain2(1))/increment:domain2(2);

d1 = repmat(domain1',[1 length(domain1)]);
d2 = repmat(domain2,[length(domain2) 1]);

vals = model.predict(model,[d1(:) d2(:)]);
if size(vals,1) ~= length(d1(:))
    error('Output of model.predict should have T rows');
elseif size(vals,2) ~= 1
    error('Output of model.predict should have 1 column');
end

zData = reshape(vals,size(d1));
contourf(d1,d2,zData+rand(size(zData))/1000,[1 1.5],'k');
if all(zData(:) == 1)
    cm = [0 0 .5];
elseif all(zData(:) == 2)
    cm = [.5 0 0];
else
    cm = [0 0 .5;.5 0 0];
end
colormap(cm);

plot(X(y==1,1),X(y==1,2),'b+');hold on;
plot(X(y==2,1),X(y==2,2),'ro');
