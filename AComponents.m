function [Left,Right,Top,Bottom,Center] = AComponents(x,y,D_Matrix,Abs_Terms)

%Dimensional Information
col=length(x);
row=length(y);
%Vector Bank
Left=zeros((col-1)*row,1)./0;
Right=zeros((col-1)*row,1)./0;
Bottom=zeros((row-1)*col,1)./0;
Top=zeros((row-1)*col,1)./0;
Center=zeros(row*col,1)./0;

%INNER POINTS
for j=(length(y)-1):-1:2 
    for i=2:length(x)-1
        %Deltas and Epsilons
        d1=abs(x(i)-x(i-1));
        e1=abs(y(j)-y(j+1));
        d2=abs(x(i+1)-x(i));
        e2=abs(y(j-1)-y(j));
        %Influence of Flux (Coefficients)
        a_L=-(D_Matrix(j,i-1)*e1+D_Matrix(j-1,i-1)*e2)/(2*d1);
        a_R=-(D_Matrix(j,i)*e1+D_Matrix(j-1,i)*e2)/(2*d2);
        a_B=-(D_Matrix(j,i-1)*d1+D_Matrix(j,i)*d2)/(2*e1);
        a_T=-(D_Matrix(j-1,i-1)*d1+D_Matrix(j-1,i)*d2)/(2*e2);
        a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_R+a_B+a_T);
        %Sort into Vector Banks
        Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
        Right((length(y)-j)*(length(x)-1)+i)=a_R;
        Bottom((length(y)-j-1)*length(x)+i)=a_B;
        Top((length(y)-j)*length(x)+i)=a_T;
        Center((length(y)-j)*length(x)+i)=a_C;
    end
end
%REFLECTING SIDES
for j=(length(y)-1):-1:2 %RIGHT
    i=length(x);
    %Deltas and Epsilons
    d1=abs(x(i)-x(i-1));
    e1=abs(y(j)-y(j+1));
    %d2=abs(x(i+1)-x(i));
    e2=abs(y(j-1)-y(j));
    
    %Influence of Flux (Coefficients)
    a_L=-(D_Matrix(j,i-1)*e1+D_Matrix(j-1,i-1)*e2)/(2*d1);
    %a_R=-(D_Matrix(j,i)*e1+D_Matrix(j-1,i)*e2)/(2*d2);
    a_B=-(D_Matrix(j,i-1)*d1)/(2*e1);
    a_T=-(D_Matrix(j-1,i-1)*d1)/(2*e2);
    a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_B+a_T);
    
    %Sort into Vector Banks
    Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
    %Right((length(y)-j)*(length(x)-1)+i)=a_R;
    Bottom((length(y)-j-1)*length(x)+i)=a_B;
    Top((length(y)-j)*length(x)+i)=a_T;
    Center((length(y)-j)*length(x)+i)=a_C;
end 
for i=2:length(x)-1 %TOP
    j=1;
    %Deltas and Epsilons
    d1=abs(x(i)-x(i-1));
    e1=abs(y(j)-y(j+1));
    d2=abs(x(i+1)-x(i));
    %e2=abs(y(j-1)-y(j));
    
    %Influence of Flux (Coefficients)
    a_L=-(D_Matrix(j,i-1)*e1)/(2*d1);
    a_R=-(D_Matrix(j,i)*e1)/(2*d2);
    a_B=-(D_Matrix(j,i-1)*d1+D_Matrix(j,i)*d2)/(2*e1);
    %a_T=-(D_Matrix(j-1,i-1)*d1)/(2*e2);
    a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L++a_R+a_B);
    
    %Sort into Vector Banks
    Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
    Right((length(y)-j)*(length(x)-1)+i)=a_R;
    Bottom((length(y)-j-1)*length(x)+i)=a_B;
    %Top((length(y)-j)*length(x)+i)=a_T;
    Center((length(y)-j)*length(x)+i)=a_C;
end

% % % %VACUUM SIDES (MUST CHANGE THIS) %THIS DOESN'T ACTUALLY MATTER???
% % % for j=(length(y)-1):-1:2 %LEFT
% % %     i=1;
% % %     %Deltas and Epsilons
% % %     %d1=abs(x(i)-x(i-1));
% % %     e1=abs(y(j)-y(j+1));
% % %     d2=abs(x(i+1)-x(i));
% % %     e2=abs(y(j-1)-y(j));
% % %     
% % %     %Influence of Flux (Coefficients)
% % %     %a_L=-(D_Matrix(j,i-1)*e1+D_Matrix(j-1,i-1)*e2)/(2*d1);
% % %     a_R=-(D_Matrix(j,i)*e1+D_Matrix(j-1,i)*e2)/(2*d2);
% % %     a_B=-(D_Matrix(j,i)*d1)/(2*e1);
% % %     a_T=-(D_Matrix(j-1,i)*d2)/(2*e2);
% % %     a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_R+a_B+a_T);
% % %     
% % %     %Sort into Vector Banks
% % %     %Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
% % %     Right((length(y)-j)*(length(x)-1)+i)=a_R;
% % %     Bottom((length(y)-j-1)*length(x)+i)=a_B;
% % %     Top((length(y)-j)*length(x)+i)=a_T;
% % %     Center((length(y)-j)*length(x)+i)=a_C;
% % % end
% % % for i=2:length(x)-1 %BOTTOM
% % %     j=length(y);
% % %     %Deltas and Epsilons
% % %     d1=abs(x(i)-x(i-1));
% % %     %e1=abs(y(j)-y(j+1));
% % %     d2=abs(x(i+1)-x(i));
% % %     e2=abs(y(j-1)-y(j));
% % %     
% % %     %Influence of Flux (Coefficients)
% % %     a_L=-(D_Matrix(j-1,i-1)*e1)/(2*d1);
% % %     a_R=-(D_Matrix(j-1,i)*e1)/(2*d2);
% % %     %a_B=-(D_Matrix(j,i-1)*d1+D_Matrix(j,i)*d2)/(2*e1);
% % %     a_T=-(D_Matrix(j-1,i-1)*d1)/(2*e2);
% % %     a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_R+a_T);
% % %     
% % %     %Sort into Vector Banks
% % %     Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
% % %     Right((length(y)-j)*(length(x)-1)+i)=a_R;
% % %     %Bottom((length(y)-j-1)*length(x)+i)=a_B;
% % %     Top((length(y)-j)*length(x)+i)=a_T;
% % %     Center((length(y)-j)*length(x)+i)=a_C;
% % % end

% % % %CORNERS
% % % i=1; %BOTTOM LEFT
% % % j=length(y);
% % %     %Deltas and Epsilons
% % %     %d1=abs(x(i)-x(i-1));
% % %     %e1=abs(y(j)-y(j+1));
% % %     d2=abs(x(i+1)-x(i));
% % %     e2=abs(y(j-1)-y(j));
% % %     
% % %     %Influence of Flux (Coefficients)
% % %     %a_L=-(D_Matrix(j,i-1)*e1+D_Matrix(j-1,i-1)*e2)/(2*d1);
% % %     a_R=-(D_Matrix(j-1,i)*e2)/(2*d2);
% % %     %a_B=-(D_Matrix(j,i-1)*d1+D_Matrix(j,i)*d2)/(2*e1);
% % %     a_T=-(D_Matrix(j-1,i)*d2)/(2*e2);
% % %     a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_R+a_T);
% % %     
% % %     %Sort into Vector Banks
% % %     %Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
% % %     Right((length(y)-j)*(length(x)-1)+i)=a_R;
% % %     %Bottom((length(y)-j-1)*length(x)+i)=a_B;
% % %     Top((length(y)-j)*length(x)+i)=a_T;
% % %     Center((length(y)-j)*length(x)+i)=a_C;
% % % 
% % % 
% % % i=length(x); %BOTTOM RIGHT
% % % j=length(y);
% % % %Deltas and Epsilons
% % %     d1=abs(x(i)-x(i-1));
% % %     %e1=abs(y(j)-y(j+1));
% % %     %d2=abs(x(i+1)-x(i));
% % %     e2=abs(y(j-1)-y(j));
% % %     
% % %     %Influence of Flux (Coefficients)
% % %     a_L=-(D_Matrix(j-1,i-1)*e2)/(2*d1);
% % %     %a_R=-(D_Matrix(j,i)*e1+D_Matrix(j-1,i)*e2)/(2*d2);
% % %     %a_B=-(D_Matrix(j,i-1)*d1+D_Matrix(j,i)*d2)/(2*e1);
% % %     a_T=-(D_Matrix(j-1,i-1)*d1)/(2*e2);
% % %     a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_T);
% % %     
% % %     %Sort into Vector Banks
% % %     Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
% % %     %Right((length(y)-j)*(length(x)-1)+i)=a_R;
% % %     %Bottom((length(y)-j-1)*length(x)+i)=a_B;
% % %     Top((length(y)-j)*length(x)+i)=a_T;
% % %     Center((length(y)-j)*length(x)+i)=a_C;
% % % 
% % % i=1; %TOP LEFT
% % % j=1; 
% % %     %Deltas and Epsilons
% % %     %d1=abs(x(i)-x(i-1));
% % %     e1=abs(y(j)-y(j+1));
% % %     d2=abs(x(i+1)-x(i));
% % %     %e2=abs(y(j-1)-y(j));
% % %     
% % %     %Influence of Flux (Coefficients)
% % %     %a_L=-(D_Matrix(j,i-1)*e1+D_Matrix(j-1,i-1)*e2)/(2*d1);
% % %     a_R=-(D_Matrix(j,i)*e1)/(2*d2);
% % %     a_B=-(D_Matrix(j,i)*d2)/(2*e1);
% % %     %a_T=-(D_Matrix(j-1,i-1)*d1+D_Matrix(j-1,i)*d2)/(2*e2);
% % %     a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_R+a_B+a_T);
% % %     
% % %     %Sort into Vector Banks
% % %     %Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
% % %     Right((length(y)-j)*(length(x)-1)+i)=a_R;
% % %     Bottom((length(y)-j-1)*length(x)+i)=a_B;
% % %     %Top((length(y)-j)*length(x)+i)=a_T;
% % %     Center((length(y)-j)*length(x)+i)=a_C;

i=length(x); %TOP RIGHT %THE ONLY ONE THAT MATTERS?
j=1;
    %Deltas and Epsilons
    d1=abs(x(i)-x(i-1));
    e1=abs(y(j)-y(j+1));
    %d2=abs(x(i+1)-x(i));
    %e2=abs(y(j-1)-y(j));
    
    %Influence of Flux (Coefficients)
    a_L=-(D_Matrix(j,i-1)*e1)/(2*d1);
    %a_R=-(D_Matrix(j,i)*e1+D_Matrix(j-1,i)*e2)/(2*d2);
    a_B=-(D_Matrix(j,i-1)*d1)/(2*e1);
    %a_T=-(D_Matrix(j-1,i-1)*d1+D_Matrix(j-1,i)*d2)/(2*e2);
    a_C=Abs_Terms(length(x)*length(y)-j*length(x)+i)-(a_L+a_B);
    
    %Sort into Vector Banks
    Left((length(y)-j)*(length(x)-1)+i-1)=a_L;
    %Right((length(y)-j)*(length(x)-1)+i)=a_R;
    Bottom((length(y)-j-1)*length(x)+i)=a_B;
    %Top((length(y)-j)*length(x)+i)=a_T;
    Center((length(y)-j)*length(x)+i)=a_C;
end
