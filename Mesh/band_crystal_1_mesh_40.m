zz

N = 40

Mesh = Initial_Mesh(N);

material = 1;
Mesh =  Material_mark(Mesh,material);

% figure,  plot_material(Mesh)
Mesh_0 = Initial_Mesh(N);

%%

tic
Stiff = Assemble_Maxwell(Mesh, 'stiff');
toc

tic
Stiff0 = Assemble_Maxwell(Mesh_0, 'stiff');
toc

tic
Mass = Assemble_Maxwell_mass(Mesh, 'mass');
toc

tic
B = Assemble_B(Mesh);
toc

tic
[A_pat, B_pat] = Pattern_A_B(Mesh);
toc

tic
[A_shift, B_shift] = shift_matrices(Mesh);
toc

%%

save data_crystal_1_mesh_40












