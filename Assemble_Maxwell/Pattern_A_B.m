
function [A_pat, B_pat] = Pattern_A_B(Mesh)

nl = Mesh.nlfb.line;
nn = Mesh.nlfb.node;

A_pat = spalloc(nl,nl,nl*33);

B_pat = spalloc(nn,nl,nl*18);

tic

local_A_pat = ones(12,12);
local_B_pat = ones(8,12);


for i = 1 : Mesh.nlfb.elem
    
    i;
    elem = Mesh.ELEM(i);
    Ind_l = elem.index_line;
    Ind_n = elem.index_node;
    
    A_pat(Ind_l, Ind_l) = local_A_pat;
    B_pat(Ind_n, Ind_l) = local_B_pat;

end

end




