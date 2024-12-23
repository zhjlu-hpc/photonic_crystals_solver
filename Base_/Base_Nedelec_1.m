
function V = Base_Nedelec_1(elem,Sign,X)

x = X(1);
y = X(2);
z = X(3);

%sX =exp((-i(X - elem.midp.line)*k'));

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

xd = [1,0,0];
yd = [0,1,0];
zd = [0,0,1];

if  strcmpi(Sign,'Original')
    
    
    %     V = [
    %         Ly1 * Lz1 * xd;
    %         Ly2 * Lz1 * xd;
    %         Ly2 * Lz2 * xd;
    %         Ly1 * Lz2 * xd;
    %
    %         Lx1 * Lz1 * yd;
    %         Lx2 * Lz1 * yd;
    %         Lx2 * Lz2 * yd;
    %         Lx1 * Lz2 * yd;
    %
    %         Lx1 * Ly1 * zd;
    %         Lx2 * Ly1 * zd;
    %         Lx2 * Ly2 * zd;
    %         Lx1 * Ly2 * zd;
    %         ];
    
    V = [
        Ly1 * Lz1 * xd;
        Lx2 * Lz1 * yd;
        Ly2 * Lz1 * xd;
        Lx1 * Lz1 * yd;
        
        Lx1 * Ly1 * zd;
        Lx2 * Ly1 * zd;
        Lx2 * Ly2 * zd;
        Lx1 * Ly2 * zd;
        
        Ly1 * Lz2 * xd;
        Lx2 * Lz2 * yd;
        Ly2 * Lz2 * xd;
        Lx1 * Lz2 * yd;
        ];
    
    
elseif strcmpi(Sign,'Curl')
    
    %     V = [
    %         0, Ly1 * dLz1, - dLy1 * Lz1;
    %         0, Ly2 * dLz1, - dLy2 * Lz1;
    %         0, Ly1 * dLz2, - dLy1 * Lz2;
    %         0, Ly2 * dLz2, - dLy2 * Lz2;
    %
    %         - Lx1 * dLz1, 0, dLx1 * Lz1;
    %         - Lx2 * dLz1, 0, dLx2 * Lz1;
    %         - Lx2 * dLz2, 0, dLx2 * Lz2;
    %         - Lx1 * dLz2, 0, dLx1 * Lz2;
    %
    % %         dLx1 * Ly1, - Lx1 * dLy1, 0;
    % %         dLx2 * Ly1, - Lx2 * dLy1, 0;
    % %         dLx2 * Ly2, - Lx2 * dLy2, 0;
    % %         dLx1 * Ly2, - Lx1 * dLy2, 0;
    %
    %         Lx1 * dLy1, - dLx1 * Ly1, 0;
    %         Lx2 * dLy1, - dLx2 * Ly1, 0;
    %         Lx2 * dLy2, - dLx2 * Ly2, 0;
    %         Lx1 * dLy2, - dLx1 * Ly2, 0;
    %
    %         ];
    
    
    V = [
        0, Ly1 * dLz1, - dLy1 * Lz1;
        - Lx2 * dLz1, 0, dLx2 * Lz1;
        0, Ly2 * dLz1, - dLy2 * Lz1;
        - Lx1 * dLz1, 0, dLx1 * Lz1;
        
        Lx1 * dLy1, - dLx1 * Ly1, 0;
        Lx2 * dLy1, - dLx2 * Ly1, 0;
        Lx2 * dLy2, - dLx2 * Ly2, 0;
        Lx1 * dLy2, - dLx1 * Ly2, 0;
        
        0, Ly1 * dLz2, - dLy1 * Lz2;
        - Lx2 * dLz2, 0, dLx2 * Lz2;
        0, Ly2 * dLz2, - dLy2 * Lz2;
        - Lx1 * dLz2, 0, dLx1 * Lz2;
        ];
    
elseif strcmpi(Sign,'Div')
    V = [
        Ly1 * Lz1 * xd;
        Lx2 * Lz1 * yd;
        Ly2 * Lz1 * xd;
        Lx1 * Lz1 * yd;
        
        Lx1 * Ly1 * zd;
        Lx2 * Ly1 * zd;
        Lx2 * Ly2 * zd;
        Lx1 * Ly2 * zd;
        
        Ly1 * Lz2 * xd;
        Lx2 * Lz2 * yd;
        Ly2 * Lz2 * xd;
        Lx1 * Lz2 * yd;
        ];

else
    error(' wrong input of Nedelec base type');
end

end










