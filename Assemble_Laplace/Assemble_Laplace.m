
function Mat = Assemble_Laplace(Mesh, Sign)

% zz
% N = 10;
% %Sign = 'stiff';
% Sign = 'mass';
% Mesh = Initial_Mesh(N);

elem = Mesh.ELEM(1);

matrix_local = Laplace_local_matrix(elem, Sign);

Mat = sparse(Mesh.nlfb.node, Mesh.nlfb.node);
mat_part = Mat;

part_N = 50;

if Mesh.nlfb.elem < part_N * 10
    
    for i = 1 : Mesh.nlfb.elem
        
        Ind = Mesh.ELEM(i).index_node;
        Mat(Ind, Ind) = Mat(Ind, Ind) + matrix_local;
        
    end
    
else
    
    part_nn = floor(Mesh.nlfb.elem/part_N);
    for k = 1 : part_N
        k
        for i = ((k-1)*part_nn+1) : (k*part_nn)
            Ind = Mesh.ELEM(i).index_node;
            mat_part(Ind, Ind) = mat_part(Ind, Ind) + matrix_local;
        end
        Mat = Mat + mat_part;
        mat_part = mat_part*0;
    end
    
    for i = (k*part_nn + 1) : Mesh.nlfb.elem
        Ind = Mesh.ELEM(i).index_node;
        mat_part(Ind, Ind) = mat_part(Ind, Ind) + matrix_local;
    end
    Mat = Mat + mat_part;
    mat_part = mat_part*0;
    
end

end







