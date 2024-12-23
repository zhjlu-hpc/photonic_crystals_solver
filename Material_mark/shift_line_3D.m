
function SS = shift_line_3D

K = [0,0,0];
L = [1,0,0];
M = [1,1,0];
N = [1,1,1];


PP = [0,0,0;
    1,0,0;
    1,1,0;
    1,1,1;
    0,0,0]*pi;

N = 10;

SS = [];

%SS = [SS;PP(1,:)];

for i = 1 : 4
    
    dd = (PP(i+1,:) - PP(i,:))/N;
    
    for j = 1 : N
        SS = [SS;
            PP(i,:) + dd*j];
    end
    
end

SS = [SS(end,:);SS];

end














