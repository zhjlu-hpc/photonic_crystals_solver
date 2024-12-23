

zz

load('data_FDM\FDM_2D_102.mat')

%    load('data_FDM\FDM_3D_52.mat')

%  load('data_FDM\FDM_3D_102.mat')

N = max(size(A));

B = speye(N);

sigma = -0;

%%
tol = 10^(-10);
eigNum = 10;
resNum = 0;
iterMax = 1000;

NN = size(A,1);
Xr = rand(NN,eigNum);

[L,U] = ilu(A);

%%
isGPU = 0;

L = []; U = [];

[lambda,X,History] = lobpcg_GPU(A,B,Xr,eigNum,resNum,tol,iterMax,L,U,isGPU);


