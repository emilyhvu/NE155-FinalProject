function [A,b,Phi,Guess] = PopulateA(A,b,Guess,x,y,Center,Top,Bottom,Left,Right)

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

% % Phi=zeros(length(x)*length(y),1)./0;
% % Indices=[];
% % for i=1:length(x)*length(y) %Deletes Rows/Columns Corresponding to Vacuum Boundary Conditions
% %     if isnan(A(i,i))
% %         Indices=[Indices i];
% %         Phi(i)=0; %Boundary Condition 0
% %     end
% % end
% % A(Indices,:)=[];
% % A(:,Indices)=[];
% % b(Indices)=[];
% % Guess(Indices)=[];

for i=1:length(b)
    if isnan(b(i)) %Loop through and find NaN in b. 
        b(i)=0;
        A(i,:)=zeros(1,size(A,1)); %Replace whole row with 0
        A(i,i)=1; %Replace A(i,i) with 1
    end
end

Phi=ones(length(x)*length(y),1)/norm(ones(length(x)*length(y),1),2);

end