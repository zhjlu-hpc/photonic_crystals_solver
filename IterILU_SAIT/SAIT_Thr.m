function M = SAIT_Thr(T,tau,m)

I = speye(size(T,1));
Dn = diag(diag(T).^(-1));
T0 = Dn*(I-T);
M = I;

for i = 1 : m
    
    i
    
    M = T0*M + I;
    P = (abs(M)>tau);
    M = M.*P;
    
    nnzM(i) = nnz(M)/nnz(T)
    
end

M = M*Dn;

figure
plot(nnzM)

end