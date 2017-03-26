function [xFake,yFake] = FakeGrid(x,y)

xFake=[];
for i=1:length(x)-1 
    xFake=[xFake x(i)+((x(i+1)-x(i)))/2];
end
xFake=[x(1) xFake x(length(x))];

yFake=[];
for i=1:length(y)-1 
    yFake=[yFake y(i)+((y(i+1)-y(i)))/2];
end
yFake=[y(1) yFake y(length(y))];

end