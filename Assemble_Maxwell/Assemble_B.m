function Mat = Assemble_B(Mesh)

% zz
% N = 10;
% %Sign = 'stiff';
% Sign = 'mass';
% Mesh = Initial_Mesh(N);

elem = Mesh.ELEM(1);

matrix_local = B_local_matrix( elem );
matrix_local = sparse(matrix_local);

% Mat = sparse(Mesh.nlfb.node, Mesh.nlfb.line);
% mat_part = Mat;

Mat = spalloc(Mesh.nlfb.node, Mesh.nlfb.line, Mesh.nlfb.line*18);
mat_part = Mat;

part_N = 50;
t1 = cputime;

if Mesh.nlfb.elem < part_N * 10
    
    for i = 1 : Mesh.nlfb.elem
        
        Ind_edge = Mesh.ELEM(i).index_line;
        Ind_node = Mesh.ELEM(i).index_node;
        Mat(Ind_node, Ind_edge) = Mat(Ind_node, Ind_edge) + matrix_local;
        
    end
    
else
    
    
    part_nn = floor(Mesh.nlfb.elem/part_N);
    for k = 1 : part_N
        k
        
        t2 = cputime;
        tt = t2 - t1
        t1 = t2;
        
        for i = ((k-1)*part_nn+1) : (k*part_nn)
            Ind_edge = Mesh.ELEM(i).index_line;
            Ind_node = Mesh.ELEM(i).index_node;
            mat_part(Ind_node, Ind_edge) = mat_part(Ind_node, Ind_edge) + matrix_local;
        end
        Mat = Mat + mat_part;
        mat_part = mat_part*0;
    end
    
    for i = (k*part_nn + 1) : Mesh.nlfb.elem
        Ind_edge = Mesh.ELEM(i).index_line;
        Ind_node = Mesh.ELEM(i).index_node;
        mat_part(Ind_node, Ind_edge) = mat_part(Ind_node, Ind_edge) + matrix_local;
    end
    Mat = Mat + mat_part;
    mat_part = mat_part*0;
    
end

end

