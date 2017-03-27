function [Abs_Terms,b] = PopulateAbsb(b,x,y,A_Matrix,S_Matrix)

Abs_Terms=b; %To Populate with Absorption Terms

%INNER POINTS
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
        Abs=A_Matrix(j,i-1)*V1+A_Matrix(j,i)*V2+A_Matrix(j-1,i)*V3+A_Matrix(j-1,i-1)*V4;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        %b Vector Inner Points
        Source_Term=S_Matrix(j,i-1)*V1+S_Matrix(j,i)*V2+S_Matrix(j-1,i)*V3+S_Matrix(j-1,i-1)*V4;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
    end
end
%REFLECTING SIDES
for j=(length(y)-1):-1:2 %RIGHT
    i=length(x);
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    %d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);
    
    %Volume On Left Side
    V1=1/4*d1*e1;
    %V2=1/4*d2*e1;
    %V3=1/4*d2*e2;
    V4=1/4*d1*e2;
    
    Abs=A_Matrix(j,i-1)*V1+A_Matrix(j-1,i-1)*V4;
    Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
    %b Vector Inner Points
    Source_Term=S_Matrix(j,i-1)*V1+S_Matrix(j-1,i-1)*V4;
    b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
end
for i=2:length(x)-1 %TOP
    j=1;
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    %e2=y(j-1)-y(j);
            
    %Volume On Bottom Side
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

%VACUUM SIDES (NEED TO CHANGE THIS)
for j=(length(y)-1):-1:2 %LEFT
    i=1;
    %Deltas and Epsilons
    %d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);
            
    %Volume on Right Side
    %V1=1/4*d1*e1;
    V2=1/4*d2*e1;
    V3=1/4*d2*e2;
    %V4=1/4*d1*e2;
    Abs=A_Matrix(j,i)*V2+A_Matrix(j-1,i)*V3;
    Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
    %b Vector Inner Points
    Source_Term=S_Matrix(j,i)*V2+S_Matrix(j-1,i)*V3;
    b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
end
for i=2:length(x)-1 %BOTTOM
    j=length(y);
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    %e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);
    
    %Volume on Top Side
    %V1=1/4*d1*e1;
    %V2=1/4*d2*e1;
    V3=1/4*d2*e2;
    V4=1/4*d1*e2;
    Abs=A_Matrix(j-1,i)*V3+A_Matrix(j-1,i-1)*V4;
    Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
    %b Vector Inner Points
    Source_Term=S_Matrix(j-1,i)*V3+S_Matrix(j-1,i-1)*V4;
    b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position
end

%CORNERS
i=1; %BOTTOM LEFT
j=length(y);
    %Deltas and Epsilons
    %d1=x(i)-x(i-1);
    %e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);

        %Top Right Volume
        %V1=1/4*d1*e1;
        %V2=1/4*d2*e1;
        V3=1/4*d2*e2;
        %V4=1/4*d1*e2;
        Abs=A_Matrix(j-1,i)*V3;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        %b Vector Inner Points
        Source_Term=S_Matrix(j-1,i)*V3;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position

i=length(x); %BOTTOM RIGHT
j=length(y);
%Deltas and Epsilons
    d1=x(i)-x(i-1);
    %e1=y(j)-y(j+1);
    %d2=x(i+1)-x(i);
    e2=y(j-1)-y(j);
    
        %Top Left Volume
        %V1=1/4*d1*e1;
        %V2=1/4*d2*e1;
        %V3=1/4*d2*e2;
        V4=1/4*d1*e2;
        Abs=A_Matrix(j-1,i-1)*V4;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        %b Vector Inner Points
        Source_Term=S_Matrix(j-1,i-1)*V4;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position

i=1; %TOP LEFT
j=1; 
    %Deltas and Epsilons
    %d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    d2=x(i+1)-x(i);
    %e2=y(j-1)-y(j);
    
        %Bottom Right Volume
        %V1=1/4*d1*e1;
        V2=1/4*d2*e1;
        %V3=1/4*d2*e2;
        %V4=1/4*d1*e2;
        Abs=A_Matrix(j,i)*V2;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        %b Vector Inner Points
        Source_Term=S_Matrix(j,i)*V2;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position

i=length(x); %TOP RIGHT
j=1;
    %Deltas and Epsilons
    d1=x(i)-x(i-1);
    e1=y(j)-y(j+1);
    %d2=x(i+1)-x(i);
    %e2=y(j-1)-y(j);
    
        %Bottom Left Volume
        V1=1/4*d1*e1;
        %V2=1/4*d2*e1;
        %V3=1/4*d2*e2;
        %V4=1/4*d1*e2;
        Abs=A_Matrix(j,i-1)*V1;
        Abs_Terms(length(x)*length(y)-j*length(x)+i)=Abs; %Puts Abs in Correct Position
        %b Vector Inner Points
        Source_Term=S_Matrix(j,i-1)*V1;
        b(length(x)*length(y)-j*length(x)+i)=Source_Term; %Puts Source Term in Correct Position

end