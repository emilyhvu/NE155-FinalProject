function [Input_Data] = InputEcho(x,y,D_Matrix,A_Matrix,S_Matrix,Error)

%Delta and Epsilon Values
Delta_Values=[];
for i=1:length(x)-1
    Delta_Values=[Delta_Values abs(x(i+1)-x(i))];
end
Epsilon_Values=[];
for i=1:length(y)-1
    Epsilon_Values=[Epsilon_Values abs(y(i+1)-y(i))];
end

%Put Dimensions in Struct Array
% for i=1:length(x)-1
%     for j=length(y)-1:-1:1
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).Delta=Delta_Values(i);
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).Epsilon=Epsilon_Values(j);
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).Diffusion_Coeff=D_Matrix(j,i);
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).Absorption_XSec_Area=A_Matrix(j,i);
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).Source=S_Matrix(j,i);
%         Input_Data((length(y)-j-1)*(length(x)-1)+i).RelativeError=Error;
%     end
% end

for i=1:length(x)-1
    for j=length(y)-1:-1:1
        Input_Data(j,i).Delta=Delta_Values(i);
        Input_Data(j,i).Epsilon=Epsilon_Values(j);
        Input_Data(j,i).Diffusion_Coeff=D_Matrix(j,i);
        Input_Data(j,i).Absorption_XSec_Area=A_Matrix(j,i);
        Input_Data(j,i).Source=S_Matrix(j,i);
        Input_Data(j,i).RelativeError=Error;
    end
end

end
