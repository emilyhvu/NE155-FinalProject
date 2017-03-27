function [A] = PopulateA(A,x,y,Center,Top,Bottom,Left,Right)

%Center Placement
for i=1:length(x)*length(y)
    A(i,i)=Center(i);
end

%Top and Bottom Placement
for i=1:length(Top)
    A(i,i+length(x)*length(y)-length(Top))=Top(i);%Top
    A(i+length(x)*length(y)-length(Bottom),i)=Bottom(i); %Bottom
end

%Left and Right Placement
A_Index=1;
V_Index=1;
for i=1:length(x)*length(y)
    skip=rem(i,length(x));
    if skip~=0 %Replaces A Position with Right and Left Components
        A(A_Index,A_Index+1)=Right(V_Index); %Right
        A(A_Index+1,A_Index)=Left(V_Index); %Left
        A_Index=A_Index+1;
        V_Index=V_Index+1;
    else %Skips Factor of length(x)
        A_Index=A_Index+1;
    end
end
end