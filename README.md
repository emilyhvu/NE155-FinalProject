# NE155-FinalProject
2d Diffusion Equation Solver

Status of Code: Version 1.0-Operational

How to execute the code: 

Ensure that the files Diffusion2D.m, Check.m, InputEcho.m, PopulateAbsb.m, AComponents.m, PopulateA.m, and GaussSiedel.m are all in the same directory, and provide x vector, y vector, diffusion matrix, absorption cross section matrix, source matrix, and allowed error value. Input files Incorrect.mat, Uniform.mat, NonUniform.mat, UniformFine.mat, and NonUniformFine.mat are provided. 

  -x vector (x):
  
    Gives the positions of material edges in the x direction of a mesh. 
    Dimensions: n x 1
    Entries: May be negative
    
  -y vector (y): 
  
    Gives the positions of material edges in the y direction of a mesh. 
    Dimensions: m x 1
    Entries: May be negative
    
  -diffusion matrix (D_Matrix): 
  
    Provides the material's diffusion coefficient of each cell defined by mesh grid
    Dimensions: (m-1)x(n-1)
    Entries: Non-negative
    
  -absorption cross section area matrix (A_Matrix):
  
    Provides the material's absorption cross section area of each cell defined by mesh grid
    Dimensions: (m-1)x(n-1)
    Entries: Non-negative
    
  -source matrix (S_Matrix):
  
    Provides the source of each cell defined by mesh grid
    Dimensions: (m-1)x(n-1)
    Entries: Non-negative
    
  -error value (Error): 
  
    Minimum absolute error allowed when solving the 2D diffusion equation using Gauss Seidel Iterative Method
    Dimensions: 1 x 1
    Entry: Non-negative

Problem solved by code:

The 2D neutron diffusion equation will by solved by this code with vaccuum boundary conditions at the left and bottom sides and reflecting boundary conditions at the top and right sides. 

Expected Input:

An x vector, y vector, diffusion matrix, absorption cross section matrix, source matrix, and allowed error value must all be provided as described below. This code will work for all cases where there are non-uniform cell sizes, non-uniform sources, non-uniform materials, and different numbers of x and y cells across a mesh.
  
Resulting Output:

Code will output error statements if any input arrays are incorrect in dimensions or have non-negative elements. The input data will also be printed in a struct array, which allows the user to access input information such as constants and cell size for each cell. The solved flux vector, number of interations, a 3D plot of flux at each position of the mesh, execution times for each step as well as overall execution time, and a 3D plot of the flux across the mesh will be printed. 

Limitations and Restrictions:

Imbedded in this code are the assumptions that in each cell, the diffusion coefficient, absorption cross section, and source are constant, and solves for cases where there is a vacuum boundary condition at the bottom and left faces and a reflecting boundary condition at the top and right faces. This code will not give an accurate solution to cases that do not fit those assumptions and boundary conditions.
