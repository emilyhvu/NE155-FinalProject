function [Order_Error,Order_Success,Dimension_Error,Dimension_Success,Sign_Error,Sign_Success] = Check(x,y,D_Matrix,A_Matrix,S_Matrix)

Order_Error=[];
Order_Success=[];
Dimension_Error=[];
Dimension_Success=[];
Sign_Error=[];
Sign_Success=[];

%NUMERICAL ORDER CHECK
if issorted(x)==0
    Order_Error=[Order_Error; sprintf('Error: The entries of x must be in ascending order.')];
else
    Order_Success=[Order_Success; sprintf('Success: The entries of x are in ascending order.')];
end
if issorted(y)==0
    Order_Error=[Order_Error; sprintf('Error: The entries of y must be in ascending order.')];
else
    Order_Success=[Order_Success; sprintf('Success: The entries of y are in ascending order.')];
end

%DIMENSION CHECK
if ~isequal([length(y)-1 length(x)-1],size(D_Matrix))
    Dimension_Error=[Dimension_Error;sprintf('Error: The y dimension of D_Matrix must be one less than the length of y, and the x dimension of D_Matrix must be one less than the length of x.')];
else
    Dimension_Success=[Dimension_Success;sprintf('Success: The x and y dimensions of D_Matrix are one less than they length of x and y, respectively!')];
end
if ~isequal([length(y)-1 length(x)-1],size(A_Matrix))
    Dimension_Error=[Dimension_Error;sprintf('Error: The y dimension of A_Matrix must be one less than the length of y, and the x dimension of A_Matrix must be one less than the length of x.')];  
else
    Dimension_Success=[Dimension_Success;sprintf('Success: The x and y dimensions of A_Matrix are one less than they length of x and y, respectively!')];
end
if ~isequal([length(y)-1 length(x)-1],size(S_Matrix))
    Dimension_Error=[Dimension_Error;sprintf('Error: The y dimension of S_Matrix must be one less than the length of y, and the x dimension of S_Matrix must be one less than the length of x.')];  
else
    Dimension_Success=[Dimension_Success;sprintf('Success: The x and y dimensions of S_Matrix are one less than they length of x and y, respectively!')];
end

%SIGN CHECK
flag=0; %D_Matrix Sign Check
for i=1:size(D_Matrix,1)*size(D_Matrix,2)
    if D_Matrix(i)<0
        Sign_Error=[Sign_Error;sprintf('Error: All entries of D_Matrix must be non-negative.')];  
        flag=flag+1;
        break
    end
end
if flag==0
    Sign_Success=[Sign_Success;sprintf('Success! All entries in D_Matrix are non_negative.')];
end

flag=0; %A_Matrix Sign Check
for i=1:size(A_Matrix,1)*size(A_Matrix,2)
    if A_Matrix(i)<0
        Sign_Error=[Sign_Error;sprintf('Error: All entries of A_Matrix must be non-negative.')];  
        break
    end
end
if flag==0
    Sign_Success=[Sign_Success;sprintf('Success! All entries in A_Matrix are non_negative.')];
end

flag=0; %S_Matrix Sign Check
for i=1:size(S_Matrix,1)*size(S_Matrix,2)
    if S_Matrix(i)<0
        Sign_Error=[Sign_Error;sprintf('Error: All entries of S_Matrix must be non-negative.')];  
        break
    end
end
if flag==0
    Sign_Success=[Sign_Success;sprintf('Success! All entries in S_Matrix are non_negative.')];
end

%IF NO ERRORS
if isequal(Order_Error,[])
    Order_Error=sprintf('Congratulations! No Numerical Order Errors Found In x And y');
    Order_Success=sprintf('Congratulations! Numerical order and x and y are correct!');
end
if isequal(Sign_Error,[])
    Sign_Error=sprintf('Congratulations! No Sign Errors Found In Input Files');
    Sign_Success=sprintf('Congratulations! All array entries are non-negative!');
end
if isequal(Dimension_Error,[])
    Dimension_Error=sprintf('Congratulations! No Dimensional Errors Found In Input Files');
    Dimension_Success=sprintf('Congratulations! Array dimensions are correct!');
end
end
