function [Abs_Terms,b] = PopulateAbsb(b,x,y,A_Matrix,S_Matrix)

Abs_Terms=b; %To Populate with Absorption Terms

%Inner Points
for j=(length(y)-1):-1:2
    for i=2:length(x)-1
        %Deltas and Epsilons
        d1=x(i)-x(i-1);
        e1=y(j)-y(j+1);
        d2=x(i+1)-x(i);
        e2=y(j-1)-y(j);

        %Volume Around Inner Points
        V1=1/4*d1*e1;
        V2=1/4*d2*e1;
        V3=1/4*d2*e2;
        V4=1/4*d1*e2;
        Abs=A_Matrix(j-1,i-1)*V1+A_Matrix(j-1,i)*V2+A_Matrix(j,i)*V3+A_Matrix(j,i-1)*V4;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        
        %b Vector Inner Points
        Source_Term=S_Matrix(j-1,i-1)*V1+S_Matrix(j-1,1)*V2+S_Matrix(j,i)*V3+S_Matrix(j,i-1)*V4;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
    end
end

%Sides: Left and Bottom(Vacuum)& Right and Top(Reflecting)
%RIGHT (Reflecting)
for j=(length(y)-1):-1:2
    i=length(x);
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    %d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);
    
    %Volume Around Inner Points
    V1=1/4*d1*e1;
    %V2=1/4*d2*e1;
    %V3=1/4*d2*e2;
    V4=1/4*d1*e2;
    Abs=A_Matrix(j-1,i-1)*V1+A_Matrix(j,i-1)*V4;
    Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position

    %b Vector Inner Points
    Source_Term=S_Matrix(j-1,i-1)*V1+S_Matrix(j,i-1)*V4;
    b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
end
%TOP (Reflecting)
for i=2:length(x)-1
    j=1;
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    %e2=y(j-1)-y(j);
            
    %Volume Around Inner Points
    V1=1/4*d1*e1;
    V2=1/4*d2*e1;
    %V3=1/4*d2*e2;
    %V4=1/4*d1*e2;
    Abs=A_Matrix(j,i-1)*V1+A_Matrix(j,i)*V2;
    Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position

    %b Vector Inner Points
    Source_Term=S_Matrix(j,i-1)*V1+S_Matrix(j,i)*V2;
    b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
end
%LEFT (Vacuum)
%RIGHT (Vacumm)

%Corners



end