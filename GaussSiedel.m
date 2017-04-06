function [Other_Phi,Phi_Iter] = GaussSiedel(A,b,Guess,Error)

LplusD=A;
dim=size(A,1);
for i=1:dim %L+D Matrix (Turns Upper Elements to 0)
    LplusD(i,i+1:dim)=0;
end

U=A-LplusD; %Upper Matrix, U=A-(L+D)
P=LplusD\(-U); %Multiply -U and L+D

Other_Phi=P*Guess+LplusD\b; %first iteration with backslash to take inverse of L+D
Phi_Iter=1;
Phi_Actual=A\b; %actual solution
E_Vector=Other_Phi-Phi_Actual;
E=norm(E_Vector,2);
%E=norm(E_Vector/Phi,2); %normalizing error vector

while E>abs(Error) %tolerance
    Phi_Prev=Other_Phi; %store previous vector
    Other_Phi=P*Phi_Prev+LplusD\b; %uses last guess
    Phi_Iter=Phi_Iter+1; %counts iterations
    
    E_Vector=Other_Phi-Phi_Prev;
    E=norm(E_Vector,2);
    %E_Vector=Phi-Phi_Prev; %error vector
    %E=norm(E_Vector,2)/norm(Phi,2); %finds relative error
end

end