
function V = Base_tensor_P1(elem,Sign,X)

x = X(1);
y = X(2);
z = X(3);

%%%%% domain
x1 = elem.domain(1,1);
x2 = elem.domain(1,2);

y1 = elem.domain(2,1);
y2 = elem.domain(2,2);

z1 = elem.domain(3,1);
z2 = elem.domain(3,2);

%%%%%%
Lx1 = (x2-x)/(x2-x1);
Lx2 = (x-x1)/(x2-x1);

Ly1 = (y2-y)/(y2-y1);
Ly2 = (y-y1)/(y2-y1);

Lz1 = (z2-z)/(z2-z1);
Lz2 = (z-z1)/(z2-z1);


dLx1 = -1/(x2-x1);
dLx2 = 1/(x2-x1);

dLy1 = -1/(y2-y1);
dLy2 = 1/(y2-y1);

dLz1 = -1/(z2-z1);
dLz2 = 1/(z2-z1);

if  strcmpi(Sign,'Original')
    
    V = [
        Lx1*Ly1*Lz1;
        Lx2*Ly1*Lz1;
        Lx2*Ly2*Lz1;
        Lx1*Ly2*Lz1;
        
        Lx1*Ly1*Lz2;
        Lx2*Ly1*Lz2;
        Lx2*Ly2*Lz2;
        Lx1*Ly2*Lz2;
        ];
    
elseif strcmpi(Sign,'Gradient')
    
    V = [
        dLx1*Ly1*Lz1, Lx1*dLy1*Lz1, Lx1*Ly1*dLz1;
        dLx2*Ly1*Lz1, Lx2*dLy1*Lz1, Lx2*Ly1*dLz1;
        dLx2*Ly2*Lz1, Lx2*dLy2*Lz1, Lx2*Ly2*dLz1;
        dLx1*Ly2*Lz1, Lx1*dLy2*Lz1, Lx1*Ly2*dLz1;
        
        dLx1*Ly1*Lz2, Lx1*dLy1*Lz2, Lx1*Ly1*dLz2;
        dLx2*Ly1*Lz2, Lx2*dLy1*Lz2, Lx2*Ly1*dLz2;
        dLx2*Ly2*Lz2, Lx2*dLy2*Lz2, Lx2*Ly2*dLz2;
        dLx1*Ly2*Lz2, Lx1*dLy2*Lz2, Lx1*Ly2*dLz2;
        ];
    
else
    error(' wrong input of Lapace base sort');
end

end










