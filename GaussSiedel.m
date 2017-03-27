function [Phi,Phi_Iter] = GaussSiedel(A,b,Guess,Error,x,y)

LplusD=A;
for i=1:length(x)*length(y) %L+D Matrix (Turns Upper Elements to 0)
        LplusD(i,i+1:length(x)*length(y))=0;
end

U=A-LplusD; %Upper Matrix, U=A-(L+D)
P=LplusD\(-U); %Multiply -U and L+D

Phi=P*Guess+LplusD\b; %first iteration with backslash to take inverse of L+D
Phi_Iter=1;
Phi_Actual=A\b; %actual solution
E_Vector=Phi-Phi_Actual;
E=norm(E_Vector,2);
%E=norm(E_Vector/Phi,2); %normalizing error vector

while E>Error %tolerance
    Phi_Prev=Phi; %store previous vector
    Phi=P*Phi_Prev+LplusD\b; %uses last guess
    Phi_Iter=Phi_Iter+1; %counts iterations
    
    E_Vector=Phi-Phi_Prev;
    E=norm(E_Vector,2);
    %E_Vector=Phi-Phi_Prev; %error vector
    %E=norm(E_Vector,2)/norm(Phi,2); %finds relative error
end
end