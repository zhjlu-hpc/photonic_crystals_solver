
function Mat = Assemble_Maxwell_spalloc(Mesh, Sign)

% zz
% N = 10;
% %Sign = 'stiff';
% Sign = 'mass';
% Mesh = Initial_Mesh(N);

elem = Mesh.ELEM(1);

matrix_local = Maxwell_local_matrix(elem, Sign);

matrix_local = sparse(matrix_local);

Mat = spalloc(Mesh.nlfb.line, Mesh.nlfb.line,Mesh.nlfb.line*33);
mat_part = Mat;

part_N = 1000;

nn = floor(Mesh.nlfb.elem/part_N)

t1 = cputime;
for i = 1 : Mesh.nlfb.elem
    
    if mod(i,nn)==0
        xxx =  i/nn
        
        t2 = cputime;
        tt = t2 - t1
        t1 = t2;
    end
    
    Ind = Mesh.ELEM(i).index_line;
     Mat(Ind, Ind) = Mat(Ind, Ind) + matrix_local;
    %  Mat(Ind, Ind) =  matrix_local;
    
end


end







