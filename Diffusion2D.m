function [Dimension_Error,Dimension_Success,Sign_Error,Sign_Success,Input_Data,Phi] = Diffusion2D(x,y,D_Matrix,A_Matrix,S_Matrix,Error)

%Ax=b Set-Up and Guess
A=zeros(length(x)*length(y),length(x)*length(y));
b=zeros(length(x)*length(y),1);
Guess=ones(length(x)*length(y),1);
Guess=Guess./norm(Guess,2);
Phi=sprintf('No Solution Found. Sorry.');
Phi_Iter=0;

%Checks Dimensions and Signs
[Dimension_Error,Dimension_Success,Sign_Error,Sign_Success]=Check(x,y,D_Matrix,A_Matrix,S_Matrix);
%If there are any errors, terminate!
if ~isequal(Dimension_Error,'Congratulations! No Dimensional Errors Found In Input Files')||~isequal(Sign_Error,'Congratulations! No Sign Errors Found In Input Files')
    return
end

%Returns Input Data in Struct Array
[Input_Data]=InputEcho(x,y,D_Matrix,A_Matrix,S_Matrix,Error);

%Populate b Vector and Corresponding Absorption Terms
[Abs_Terms,b]=PopulateAbsb(b,x,y,A_Matrix,S_Matrix);

%Finds Left, Right, Top, Bottom, and Center Flux Influences for A Matrix
[Left,Right,Top,Bottom,Center]=AComponents(x,y,D_Matrix,Abs_Terms);

%Populates A with Flux Influences in Appropriate Positions
[A]=PopulateA(A,x,y,Center,Top,Bottom,Left,Right);

%Finds Solution Using Gauss Siedel Iterative Method
[Phi,Phi_Iter]=GaussSiedel(A,b,Guess,Error,x,y);



end