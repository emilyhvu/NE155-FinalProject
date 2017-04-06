function [Order_Error,Order_Success,Dimension_Error,Dimension_Success,Sign_Error,Sign_Success,Input_Data,Phi,GS_Iter,ExecutionTime,Version] = Diffusion2D(x,y,D_Matrix,A_Matrix,S_Matrix,Error)

%Ax=b Set-Up and Guess
tic
A=zeros(length(x)*length(y),length(x)*length(y));
b=zeros(length(x)*length(y),1)./0;
Guess=ones(length(x)*length(y),1);
Guess=Guess./norm(Guess,2);
Version=sprintf('2DE 1.0');

%In Case of Error
Input_Data=sprintf('Invalid Input Data. Please Try Again.');
Phi=sprintf('No Solution Found. Sorry.');
GS_Iter=0;
%ExecutionTime=0;
Error_Flag=0;
SetUp_Time=toc;

%Checks Dimensions and Signs
tic
[Order_Error,Order_Success,Dimension_Error,Dimension_Success,Sign_Error,Sign_Success]=Check(x,y,D_Matrix,A_Matrix,S_Matrix);
%If there are any errors, terminate!
InputCheck_Time=toc;
ExecutionTime=InputCheck_Time;
if ~isequal(Order_Error,'Congratulations! No Numerical Order Errors Found In x And y')||~isequal(Dimension_Error,'Congratulations! No Dimensional Errors Found In Input Files')||~isequal(Sign_Error,'Congratulations! No Sign Errors Found In Input Files')
    return
end
if Error_Flag==0
    ExecutionTime=[];
end

%Returns Input Data in Struct Array
tic
[Input_Data]=InputEcho(x,y,D_Matrix,A_Matrix,S_Matrix,Error);
InputEcho_Time=toc;

%Populate b Vector and Corresponding Absorption Terms
tic
[Abs_Terms,b]=PopulateAbsb(b,x,y,A_Matrix,S_Matrix);
PopulateAbsb_Time=toc;

%Finds Left, Right, Top, Bottom, and Center Flux Influences for A Matrix
tic
[Left,Right,Top,Bottom,Center]=AComponents(x,y,D_Matrix,Abs_Terms);
AComponents_Time=toc;

%Populates A with Flux Influences in Appropriate Positions
tic
[A,b,Phi,Guess]=PopulateA(A,b,Guess,x,y,Center,Top,Bottom,Left,Right);
PopulateA_Time=toc;

%Finds Solution Using Gauss Siedel Iterative Method
tic
[Other_Phi,GS_Iter]=GaussSiedel(A,b,Guess,Error);

Phi=Other_Phi;
%fills real phi vector (with boundary conditions) with other phi components
% % for i=1:length(Phi)
% %     if isnan(Phi(i))
% %         Phi(i)=Other_Phi(1);
% %         Other_Phi(1)=[];
% %     end
% % end
GaussSiedel_Time=toc;

%Plots Data
tic
[X,Y]=meshgrid(x,y);
Z=zeros(length(y),length(x));
j=length(y);
for i=1:length(y)
    Z(j,1:length(x))=Phi((i-1)*length(x)+1:i*length(x));
    j=j-1;
end

surf(X,Y,Z)
title('Neutron Flux Across Mesh')
xlabel('x')
ylabel('y')
zlabel('Phi')
Plot_Time=toc;

%Organize All Execution Times
ExecutionTime.SetUp=SetUp_Time;
ExecutionTime.InputCheck=InputCheck_Time;
ExecutionTime.InputEcho=InputEcho_Time;
ExecutionTime.PopulateAbsb=PopulateAbsb_Time;
ExecutionTime.AComponents=AComponents_Time;
ExecutionTime.PopulateA=PopulateA_Time;
ExecutionTime.GaussSiedel=GaussSiedel_Time;
ExecutionTime.Plot=Plot_Time;
ExecutionTime.Total=SetUp_Time+InputCheck_Time+InputEcho_Time+PopulateAbsb_Time+AComponents_Time+PopulateA_Time+GaussSiedel_Time+Plot_Time;
end