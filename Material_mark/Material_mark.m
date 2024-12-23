
function Mesh =  Material_mark(Mesh,material)

N = Mesh.ELEM(1).N;
nn = round(N/4);

if material == 0
    
elseif material ==1
    for i = 1 : Mesh.nlfb.elem
        
        cube = Mesh.ELEM(i).cube;
        if sum(cube <= nn) >= 2
            Mesh.ELEM(i).material = 13;
        end
        
    end
    
elseif material == 2
    
    for i = 1 : Mesh.nlfb.elem
        
        cube = Mesh.ELEM(i).cube;
        
        if ceil(cube(3)/nn) == 1
            if ceil(cube(2)/nn) == 1
                Mesh.ELEM(i).material = 13;
            end
            
        elseif ceil(cube(3)/nn) == 2
            
            if ceil(cube(1)/nn) == 1
                Mesh.ELEM(i).material = 13;
            end
            
        elseif ceil(cube(3)/nn) == 3
            if ceil(cube(2)/nn) == 3
                Mesh.ELEM(i).material = 13;
            end
        elseif ceil(cube(3)/nn) == 4
            if ceil(cube(1)/nn) == 3
                Mesh.ELEM(i).material = 13;
            end
        else
            
        end
        
    end
    
elseif material == 3
    for i = 1 : Mesh.nlfb.elem
        
        cube = Mesh.ELEM(i).cube;
        if cube(1) >= 2*nn
            Mesh.ELEM(i).material = 13;
        end
        
    end
    
else
    error('material type is wrong!')
end


end










