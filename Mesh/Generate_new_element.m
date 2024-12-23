
function [elem, ind_n, ind_l, ind_f] = ...
    Generate_new_element(Mesh,cube,N,ind_n,ind_l,ind_f)

NO = cube_number(cube,N);

elem = Class_cube(N,cube,NO);


%%% x-axis
if cube(1) > 1
    
    iNO = cube_number(cube - [1,0,0],N);
    
    elem.index_face(1) = Mesh(iNO).index_face(2);
    
    elem.index_node(1) = Mesh(iNO).index_node(2);
    elem.index_node(4) = Mesh(iNO).index_node(3);
    elem.index_node(8) = Mesh(iNO).index_node(7);
    elem.index_node(5) = Mesh(iNO).index_node(6);
    
    elem.index_line(4) = Mesh(iNO).index_line(2);
    elem.index_line(8) = Mesh(iNO).index_line(7);
    elem.index_line(12) = Mesh(iNO).index_line(10);
    elem.index_line(5) = Mesh(iNO).index_line(6);
    
end

%%% y-axis
if cube(2) > 1
    
    iNO = cube_number(cube - [0,1,0],N);
    
    elem.index_face(3) = Mesh(iNO).index_face(4);
    
    elem.index_node(1) = Mesh(iNO).index_node(4);
    elem.index_node(5) = Mesh(iNO).index_node(8);
    elem.index_node(6) = Mesh(iNO).index_node(7);
    elem.index_node(2) = Mesh(iNO).index_node(3);
    
    elem.index_line(5) = Mesh(iNO).index_line(8);
    elem.index_line(9) = Mesh(iNO).index_line(11);
    elem.index_line(6) = Mesh(iNO).index_line(7);
    elem.index_line(1) = Mesh(iNO).index_line(3);
    
end

%%% z-axis
if cube(3) > 1
    
    iNO = cube_number(cube - [0,0,1],N);
    
    elem.index_face(5) = Mesh(iNO).index_face(6);
    
    elem.index_node(1) = Mesh(iNO).index_node(5);
    elem.index_node(2) = Mesh(iNO).index_node(6);
    elem.index_node(3) = Mesh(iNO).index_node(7);
    elem.index_node(4) = Mesh(iNO).index_node(8);
    
    elem.index_line(1) = Mesh(iNO).index_line(9);
    elem.index_line(2) = Mesh(iNO).index_line(10);
    elem.index_line(3) = Mesh(iNO).index_line(11);
    elem.index_line(4) = Mesh(iNO).index_line(12);
    
end

%%% face
for i = 1:6
    
    if elem.index_face(i) == 0
        ind_f = ind_f + 1;
        elem.index_face(i) = ind_f;
    end
    
end

%%% node
for i = 1:8
    
    if elem.index_node(i) == 0
        ind_n = ind_n + 1;
        elem.index_node(i) = ind_n;
    end
    
end

%%% line
for i = 1:12
    
    if elem.index_line(i) == 0
        ind_l = ind_l + 1;
        elem.index_line(i) = ind_l;
    end
    
end


end

%%%%%%%%%%%%%%%%%%%%%


% node = [
%     0,0,0;
%     1,0,0;
%     1,1,0;
%     0,1,0;
%
%     0,0,1;
%     1,0,1;
%     1,1,1;
%     0,1,1;
%     ];
%
% normal = [
%     -1 0 0;
%     1 0 0;
%
%     0 -1 0;
%     0 1 0;
%
%     0 0 -1;
%     0 0 1;
%     ];
%
% line = [
%     1,2;
%     2,3;
%     4,3;
%     1,4;
%
%     1,5;
%     2,6;
%     3,7;
%     4,8;
%
%     5,6;
%     6,7;
%     8,7;
%     5,8;
%     ];
%
% face = [
%     -1 0 0;
%     1 0 0;
%
%     0 -1 0;
%     0 1 0;
%
%     0 0 -1;
%     0 0 1;
%     ];
%
% face_node = [
%     1 4 8 5;
%     2 3 7 6;
%
%     1 5 6 2;
%     4 8 7 3;
%
%     1 2 3 4;
%     5 6 7 8;
%     ];
%
% face_line = [
%     4 8 12 5;
%     2 7 10 6;
%
%     5 9 6 1;
%     8 11 7 3;
%
%     1 2 3 4;
%     9 10 11 12;
%     ];












