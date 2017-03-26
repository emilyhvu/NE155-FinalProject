function [phi] = Diffusion2D(x,y,D_Matrix,A_Matrix,S_Matrix)

%Ax=b Set-Up
col=length(x);
row=length(y);
A=zeros(row*col,row*col);
b=zeros(row*col,1);

%Fictitious Grid (May Not Be Needed)
%[xFake, yFake]=FakeGrid(x,y);

%Populate b Vector and Corresponding Absorption Terms
[Abs_Terms,b]=PopulateAbsb(b,x,y,A_Matrix,S_Matrix);

end