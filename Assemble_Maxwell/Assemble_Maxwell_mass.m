
function Mat = Assemble_Maxwell_mass(Mesh, Sign)

% zz
% N = 10;
% %Sign = 'stiff';
% Sign = 'mass';
% Mesh = Initial_Mesh(N);

elem = Mesh.ELEM(1);

matrix_local = Maxwell_local_matrix(elem, Sign);

% Mat = sparse(Mesh.nlfb.line, Mesh.nlfb.line);
% mat_part = Mat;

Mat = spalloc(Mesh.nlfb.line, Mesh.nlfb.line,Mesh.nlfb.line*33);
mat_part = Mat;

part_N = 1000;

t1 = cputime;

if Mesh.nlfb.elem < part_N * 10
    
    for i = 1 : Mesh.nlfb.elem
        
        Ind = Mesh.ELEM(i).index_line;
        material = Mesh.ELEM(i).material;
        Mat(Ind, Ind) = Mat(Ind, Ind) + matrix_local;
        
    end
    
else
    
    part_nn = floor(Mesh.nlfb.elem/part_N);
    for k = 1 : part_N
        k
        
       t2 = cputime;
       tt = t2 - t1
       t1 = t2;
        
        for i = ((k-1)*part_nn+1) : (k*part_nn)
            Ind = Mesh.ELEM(i).index_line;
            mat_part(Ind, Ind) = mat_part(Ind, Ind) + matrix_local;
        end
        Mat = Mat + mat_part;
        mat_part = mat_part*0;
    end
    
    for i = (k*part_nn + 1) : Mesh.nlfb.elem
        Ind = Mesh.ELEM(i).index_line;
        mat_part(Ind, Ind) = mat_part(Ind, Ind) + matrix_local;
    end
    Mat = Mat + mat_part;
    mat_part = mat_part*0;
    
end

end







