
clear all
clc
PATH_Needed

% the mesh size N x N x N. 
N = 4

Mesh = Initial_Mesh(N);

% three different photonic crystals are provided with material = 0,1,2
material = 1;
Mesh =  Material_mark(Mesh,material);

% figure,  plot_material(Mesh)
Mesh_0 = Initial_Mesh(N);

%%

tic
Stiff = Assemble_Maxwell(Mesh, 'stiff');
toc

tic
Stiff0 = Assemble_Maxwell(Mesh_0, 'stiff');
toc

tic
Mass = Assemble_Maxwell_mass(Mesh, 'mass');
toc

tic
B = Assemble_B(Mesh);
toc

tic
[A_pat, B_pat] = Pattern_A_B(Mesh);
toc

tic
[A_shift, B_shift] = shift_matrices(Mesh);
toc


%%
SS = shift_line_3D;


global As Bs BsT alpha inX ML MU


%%
aaa =  1*max(max(abs(Stiff)))/max(max(abs(B*B')));

alpha =  1*max(max(abs(Stiff)))/max(max(abs(B*B')));

A0 =  gather(Stiff0 + alpha * B'*B);
tic
[L,U] = ilu(A0);
toc

ML = SAIT_Thr(L,0.01,20);

D = sparse(diag(U));
Df = diag(D.^(-1));
MU = ML'*Df;

ML  = gpuArray(ML);
MU  = gpuArray(MU);

%%

As  = gpuArray(As);
Bs  = gpuArray(Bs);
BsT  = gpuArray(BsT);
alpha  = gpuArray(alpha);


%%

tol = 10^(-10);
eigNum = 35;
resNum = 10;
iterMax = 500;
NN = max(size(Stiff));
Xr = rand(NN,eigNum);

inX = gpuArray(Xr);

%%
tic
clear iterCount band1 band2 band3 band4 band5
for i = 1 : size(SS,1)
    i
    K = -1i*SS(i,:);
    
    [Aem,Bem] = shift_value_matrices(K,A_shift,B_shift,A_pat,B_pat);
    
    As = Stiff.*Aem;
    Ms = Mass.*Aem;
    Bs = B.*Bem;
    BsT = Bs';
    As  = gpuArray(As);
    Bs  = gpuArray(Bs);
    BsT  = gpuArray(BsT);
    
    
    Ass =  Stiff.*Aem;    
    Bss  = B.*Bem;
    BssT  = Bss';
    
    isGPU = 1;
    
    tic
    %[lambda,X,History] = lobpcg_GPU(A,Ms,Xr,eigNum,resNum,tol,iterMax,L,U,isGPU);
    [lambda,X,History,iter] = lobpcg_GPU_feval(@operatorAs,Ms,Xr,eigNum,resNum,tol,iterMax,@precond_A,isGPU);
    iterCount(i) = iter;
    toc
    lambda/pi/pi
    size(History)
    
    band1(:,i) = lambda/pi/pi;
    
    X = gather(X);
    
    band2(:,i) = sum(abs(X.*(Ass*X)))./sum(abs(X.*(Ms*X)))/pi/pi;
    
    band3(:,i) = eig(full(X'*Ass*X),full(X'*Ms*X))/pi/pi;
    
    band4(:,i) = diag(abs(X'*(Ass*X)))./diag(abs(X'*(Ms*X)))/pi/pi;
    
    band5(:,i) = lambda/pi/pi - 10*aaa*diag(abs(X'*(BssT*(Bss*X))))./diag(abs(X'*(Ms*X)))/pi/pi;
    
    toc
    
   %  pause
    
end

%%

figure
plot(abs(band1([1:eigNum-resNum],:)').^(0.5)/2,'.')
xlabel('band1')
%%

figure
plot(abs(band2([1:eigNum-resNum],:)').^(0.5)/2,'.')
xlabel('band2')

%%
figure
plot(abs(band3([1:eigNum-resNum],:)').^(0.5)/2,'.')
xlabel('band3')

%%
figure
plot(abs(abs(band4([1:eigNum-resNum],:)')).^(0.5)/2,'.')
xlabel('band4')

%%
figure
plot(abs(abs(band5([1:eigNum-resNum],:)')).^(0.5)/2,'.')
xlabel('band5')

%%
axis([0,41,0,1])

save data_crystal_1
