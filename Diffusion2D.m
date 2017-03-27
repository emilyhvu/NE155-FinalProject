function [Phi,Phi_Iter] = Diffusion2D(x,y,D_Matrix,A_Matrix,S_Matrix,Error)

%Ax=b Set-Up and Guess
A=zeros(length(x)*length(y),length(x)*length(y));
b=zeros(length(x)*length(y),1);
Guess=ones(length(x)*length(y),1);
Guess=Guess./norm(Guess,2);

%Fictitious Grid (May Not Be Needed)
%[xFake, yFake]=FakeGrid(x,y);

%Populate b Vector and Corresponding Absorption Terms
[Abs_Terms,b]=PopulateAbsb(b,x,y,A_Matrix,S_Matrix);

%Finds Left, Right, Top, Bottom, and Center Flux Influences for A Matrix
[Left,Right,Top,Bottom,Center]=AComponents(x,y,D_Matrix,Abs_Terms);

%Populates A with Flux Influences in Appropriate Positions
[A]=PopulateA(A,x,y,Center,Top,Bottom,Left,Right);

%Finds Solution Using Gauss Siedel Iterative Method
[Phi,Phi_Iter]=GaussSiedel(A,b,Guess,Error,x,y);



end