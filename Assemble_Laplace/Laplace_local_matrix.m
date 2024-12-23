

function  matrix_local = Laplace_local_matrix(elem, Sign)

% N = 1;
% Sign = 'stiff';
% elem = Class_cube(N,[1,1,1],1);

Gauss_body = Gauss_point_3D_cube(elem);

%pp=elem.p_Lap;

pp = 8;

matrix_local = zeros(pp,pp);

if strcmpi(Sign,'mass')
    
    for i = 1 : Gauss_body.N
        
        V=Base_tensor_P1(elem,'Original',Gauss_body.point(i,:));
        matrix_local = matrix_local + V*V'*Gauss_body.weight(i);
        
    end
    
elseif strcmpi(Sign,'stiff')
    
    for i = 1 : Gauss_body.N
        
        V = Base_tensor_P1(elem,'Gradient',Gauss_body.point(i,:));
        matrix_local = matrix_local + V*V'*Gauss_body.weight(i);
        
    end
    
else
    error('Body integral is wrong');
end

end


