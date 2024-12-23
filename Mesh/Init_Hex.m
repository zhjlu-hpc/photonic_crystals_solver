%function Mesh=Init_Hex(N)

zz
N = 5;

display('Init_Hex begins.');


NO = 0;

ind_n = 0;
ind_l = 0;
ind_f = 0;

Mesh=[];
for k=1:N
    for j=1:N
        for i=1:N
            cube=[i,j,k];
            
            [elem, ind_n, ind_l, ind_f] = ...
                Generate_new_element(Mesh,cube,N,ind_n,ind_l,ind_f);
            Mesh = [Mesh,elem];
            
        end
    end
end


nnn = (N+1)^3
fff = (N+1)*N^2*3
lll = (N+1)^2*N*3


display('Init_Hex is ok. ');




