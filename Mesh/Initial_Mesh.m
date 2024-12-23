
function Mesh = Initial_Mesh(N)


display('Initial_Mesh begins.');


ind_n = 0;
ind_l = 0;
ind_f = 0;


%%% ELEM space
ELEM = Class_cube(1,[1,1,1],1);
nn = ceil(log(N^3)/log(2));
for i = 1 : nn
    ELEM = [ELEM,ELEM];
end
ELEM([N^3:2^nn]) = [];


number = 0;

for k=1:N
    k
    for j=1:N
        for i=1:N
            
            number = number + 1;
            
            cube=[i,j,k];
            [elem, ind_n, ind_l, ind_f] = ...
                Generate_new_element_per(ELEM,cube,N,ind_n,ind_l,ind_f);
            %         ELEM = [ELEM,elem];
            ELEM(number) = elem;
            
        end
    end
end

Mesh.ELEM = ELEM;

Mesh.nlfb.N = N;
Mesh.nlfb.elem = N^3;

for i = 1 : Mesh.nlfb.elem
    max_n(i) = max(Mesh.ELEM(i).index_node);
    max_l(i) = max(Mesh.ELEM(i).index_line);
    max_f(i) = max(Mesh.ELEM(i).index_face);
end

Mesh.nlfb.node = max(max_n);
Mesh.nlfb.line = max(max_l);
Mesh.nlfb.face = max(max_f);


% Mesh.nlfb.node = (N+1)^3;
% Mesh.nlfb.line = (N+1)^2*N*3;
% Mesh.nlfb.face = N^2*(N+1)*3;



display('Initial_Mesh is ok. ');

end




