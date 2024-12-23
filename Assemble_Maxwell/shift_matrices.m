
function [A_shift, B_shift] = shift_matrices(Mesh)

nl = Mesh.nlfb.line;
nn = Mesh.nlfb.node;

A_shift.x = spalloc(nl,nl,nl*33);
A_shift.y = spalloc(nl,nl,nl*33);
A_shift.z = spalloc(nl,nl,nl*33);

B_shift.x = spalloc(nn,nl,nl*18);
B_shift.y = spalloc(nn,nl,nl*18);
B_shift.z = spalloc(nn,nl,nl*18);

%%
elem = Mesh.ELEM(1);

line_mid = elem.midp.line;
node = elem.node;

local_A_shift_x = line_mid(:,1)' - line_mid(:,1);
local_A_shift_y = line_mid(:,2)' - line_mid(:,2);
local_A_shift_z = line_mid(:,3)' - line_mid(:,3);

local_B_shift_x = line_mid(:,1)' - node(:,1);
local_B_shift_y = line_mid(:,2)' - node(:,2);
local_B_shift_z = line_mid(:,3)' - node(:,3);

%%

tic
for i = 1 : Mesh.nlfb.elem
    
    elem = Mesh.ELEM(i);
    
    Ind_l = elem.index_line;
    Ind_n = elem.index_node;
    
    if elem.cube(1)<= Mesh.nlfb.N & ...
            elem.cube(2) <= Mesh.nlfb.N & ...
            elem.cube(3) <= Mesh.nlfb.N
        
        A_shift.x(Ind_l, Ind_l) = local_A_shift_x;
        A_shift.y(Ind_l, Ind_l) = local_A_shift_y;
        A_shift.z(Ind_l, Ind_l) = local_A_shift_z;
        
        B_shift.x(Ind_n, Ind_l) = local_B_shift_x;
        B_shift.y(Ind_n, Ind_l) = local_B_shift_y;
        B_shift.z(Ind_n, Ind_l) = local_B_shift_z;
        
    else
        
        line_mid = elem.midp.line;
        node = elem.node;
        
        A_shift.x(Ind_l, Ind_l) = line_mid(:,1)' - line_mid(:,1);
        A_shift.y(Ind_l, Ind_l) = line_mid(:,2)' - line_mid(:,2);
        A_shift.z(Ind_l, Ind_l) = line_mid(:,3)' - line_mid(:,3);
        
        B_shift.x(Ind_n, Ind_l) = line_mid(:,1)' - node(:,1);
        B_shift.y(Ind_n, Ind_l) = line_mid(:,2)' - node(:,2);
        B_shift.z(Ind_n, Ind_l) = line_mid(:,3)' - node(:,3);
        
    end
    
end

end




