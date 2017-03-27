function [Dimension_Error,Dimension_Success,Sign_Error,Sign_Success,Input_Data,Phi,GS_Iter,ExecutionTime] = Diffusion2D(x,y,D_Matrix,A_Matrix,S_Matrix,Error)

%Ax=b Set-Up and Guess
tic
A=zeros(length(x)*length(y),length(x)*length(y));
b=zeros(length(x)*length(y),1);
Guess=ones(length(x)*length(y),1);
Guess=Guess./norm(Guess,2);
Phi=sprintf('No Solution Found. Sorry.');
Phi_Iter=0;
SetUp_Time=toc;

%Checks Dimensions and Signs
tic
[Dimension_Error,Dimension_Success,Sign_Error,Sign_Success]=Check(x,y,D_Matrix,A_Matrix,S_Matrix);
%If there are any errors, terminate!
InputCheck_Time=toc;
if ~isequal(Dimension_Error,'Congratulations! No Dimensional Errors Found In Input Files')||~isequal(Sign_Error,'Congratulations! No Sign Errors Found In Input Files')
    return
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
[A]=PopulateA(A,x,y,Center,Top,Bottom,Left,Right);
PopulateA_Time=toc;

%Finds Solution Using Gauss Siedel Iterative Method
tic
[Phi,GS_Iter]=GaussSiedel(A,b,Guess,Error,x,y);
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