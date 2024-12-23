
function boundary_line = Boundary_dof_line(Mesh)

N = Mesh.nlfb.N;

boundary_line = [];

for i = 1 : N
    for j = 1 : N
        
        %%% x-axis
        cube = [1,i,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_line = [boundary_line, elem.index_line(elem.face_line(1,:))];
        
        cube = [N,i,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_line = [boundary_line, elem.index_line(elem.face_line(2,:))];
        
        %%% y-axis
        cube = [i,1,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_line = [boundary_line, elem.index_line(elem.face_line(3,:))];
        
        cube = [i,N,j];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        ff = elem.index_line(elem.face_line(4,:));
        boundary_line = [boundary_line, elem.index_line(elem.face_line(4,:))];
        
        
        %%% z-axis
        cube = [i,j,1];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_line = [boundary_line, elem.index_line(elem.face_line(5,:))];
        
        cube = [i,j,N];
        NO = cube_number(cube,N);
        elem = Mesh.ELEM(NO);
        boundary_line = [boundary_line, elem.index_line(elem.face_line(6,:))];
    end
end

boundary_line = sort(boundary_line);
nnn = boundary_line - boundary_line([end,1:end-1]);

boundary_line = boundary_line(find(nnn~=0));

end














