
function boundary_node = Boundary_dof(Mesh)

N = Mesh.nlfb.N;

boundary_node = [];

for i = 1 : N
    for j = 1 : N
        
        %%%% x-axis
        cube = [1,i,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(1,:))];
        
        cube = [N,i,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(2,:))];
        
        %%%% y-axis
        cube = [i,1,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(3,:))];
        
        cube = [i,N,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(4,:))];
        
        %%%% z-axis
        cube = [i,j,1];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(5,:))];
        
        cube = [i,j,N];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_node = [boundary_node, elem.index_node(elem.face_node(6,:))];
    end
end

boundary_node = sort(boundary_node);
nnn = boundary_node - boundary_node([end,1:end-1]);

boundary_node = boundary_node(find(nnn~=0));


end












