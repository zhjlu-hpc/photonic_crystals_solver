classdef Class_cube
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        N;
        cube;
        NO;
        
        material = 1;
        plotfill = 0;
        
        index_node = zeros(1,8);
        index_line = zeros(1,12);
        index_face = zeros(1,6);
        
        
    end
    
    properties(Dependent)
        
        domain;
        node;
        line_node;
        face_node;
        face_line;
        midp;
        
    end
    
    methods
        function td=Class_cube(N,cube,NO)
            td.N = N;
            td.cube = cube;
            td.NO = NO;
        end
    end
    
    methods
        
        function domain = get.domain(obj)
            
            domain = [obj.cube'-1,obj.cube']/obj.N;
            
        end
        
        function node = get.node(obj)
            
            domain = [obj.cube'-1,obj.cube']/obj.N;
            
            node = [
                domain(1,1),domain(2,1),domain(3,1);
                domain(1,2),domain(2,1),domain(3,1);
                domain(1,2),domain(2,2),domain(3,1);
                domain(1,1),domain(2,2),domain(3,1);
                
                domain(1,1),domain(2,1),domain(3,2);
                domain(1,2),domain(2,1),domain(3,2);
                domain(1,2),domain(2,2),domain(3,2);
                domain(1,1),domain(2,2),domain(3,2);
                ];
            
        end
        
        function line_node = get.line_node(obj)
            
            line_node = [
                1,2;
                2,3;
                4,3;
                1,4;
                
                1,5;
                2,6;
                3,7;
                4,8;
                
                5,6;
                6,7;
                8,7;
                5,8;
                ];
            
        end
        
        function face_node = get.face_node(obj)
            
            face_node = [
                1 4 8 5;
                2 3 7 6;
                
                1 5 6 2;
                4 8 7 3;
                
                1 2 3 4;
                5 6 7 8;
                ];
            
        end
        
        function face_line = get.face_line(obj)
            
            face_line = [
                4 8 12 5;
                2 7 10 6;
                
                5 9 6 1;
                8 11 7 3;
                
                1 2 3 4;
                9 10 11 12;
                ];
        end
        
        function midp = get.midp(obj)
            
            midp.line = ( obj.node(obj.line_node(:,1),:) + ...
                obj.node(obj.line_node(:,2),:))/2;
            midp.face = (obj.node(obj.face_node(:,1),:) + ...
                obj.node(obj.face_node(:,2),:) + ...
                obj.node(obj.face_node(:,3),:) + ...
                obj.node(obj.face_node(:,4),:))/4;
            
        end
        
        
        
    end
    
end




