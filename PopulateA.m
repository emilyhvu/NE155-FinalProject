function [A] = PopulateA(A,x,y,Top,Bottom,Center)

%Center Placement
for i=1:length(x)*length(y)
    A(i,i)=Center(length(y)*length(x));
end

%Top and Bottom Placement
for i=1:length(Top)
    A(i,i+length(x)*length(y)-length(Top)+1)=Top(i);%Top
    A(i+length(x)*length(y)-length(Bottom)+1,i)=Bottom(i); %Bottom
end
%x=Left;
%y=Right;
%Left,Right,
end