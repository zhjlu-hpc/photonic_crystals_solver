
function  matrix_local = B_local_matrix( elem )

% N = 1;
% Sign = 'stiff';
% elem = Class_cube(N,[1,1,1],1);

Gauss_body = Gauss_point_3D_cube(elem);

%pp=elem.p_Lap;

pp1 = 12;
pp2 = 8;


matrix_local = zeros(pp2,pp1);


for i = 1 : Gauss_body.N
    
    V1 = Base_Nedelec_1(elem,'Original',Gauss_body.point(i,:));
    V2 = Base_tensor_P1(elem,'Gradient',Gauss_body.point(i,:));
    
    matrix_local = matrix_local + V2*V1'*Gauss_body.weight(i);
    
end


% else
%     error('Body integral is wrong');
% end

end


