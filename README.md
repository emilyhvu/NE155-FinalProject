# NE155-FinalProject
2d Diffusion Equation Solver

Status of Code: 
Operational but does not account for vacuum boundary conditions on left and bottom sides or corners yet.

How to execute the code: 
Ensure that the files Diffusion2D.m, Check.m, InputEcho.m, PopulateAbsb.m, AComponents.m, PopulateA.m, and GaussSiedel.m are all in the same directory, and provide x vector, y vector, diffusion matrix, absorption cross section matrix, source matrix, and allowed error value.
  -x vector (x): 
    This array gives the positions of material edges in the x direction of a mesh. 
  -y vector (y): 
    This array gives the positions of material edges in the y direction of a mesh. 
  -diffusion matrix (D_Matrix): 
    This array provides the material's diffusion coefficient of each cell defined by the x and y vectors. 
    The dimensions of this array must be (length(y)-1) by (length(x)-1)
  -absorption cross section area matrix (A_Matrix):
    This array provides the material's absorption cross section area of each cell defined by the x and y vectors.
    The dimensions of this array must be (length(y)-1) by (length(x)-1), and all entries must be non-negative.
  -source matrix (S_Matrix):
    This array provides the source of each cell defined by the x and y vectors.
    The dimensions of this array must be (length(y)-1) by (length(x)-1) and all entries must be non-negative.
  -error value (Error): 
    This value is the minimum relative error allowed when solving the 2D diffusion equation.
    The dimensions of this array must be (length(y)-1) by (length(x)-1) and all entries must be non-negative.

Problem solved by code, expected input, resulting output, and any limitations or restrictions.
  The 2D Neutron Diffusion Equation will by solved by this code. In order for this code to run properly, an x vector, y vector, diffusion matrix, absorption cross section matrix, source matrix, and allowed error value must all be provided. This code will work for all cases where there are non-uniform cell sizes, non-uniform sources, non-uniform materials, and different numbers of x and y cells across a mesh.
  
  It will output error statements if any input arrays are incorrect in dimensions or have non-negative elements. The input data will also be printed in a struct array, which allows the user to access input information such as constants and cell size for each cell. The solved flux vector, number of interations, a 2D plot of flux at each position of the mesh, and execution times for each step as well as overall execution time will be printed. However, imbedded in this code are the assumptions that in each cell, the diffusion coefficient, absorption cross section, and source are constant, and solves for cases where there is a vacuum boundary condition at the bottom and left faces and a reflecting boundary condition at the top and right faces. This code will not give an accurate solution to cases that do not fit those assumptions.
