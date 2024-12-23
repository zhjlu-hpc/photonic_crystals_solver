
function plot_material(Mesh)

figure


for i = 1 : Mesh.nlfb.elem;
    
    if Mesh.ELEM(i).material ~= 1
        
        node = Mesh.ELEM(i).node;
        face = Mesh.ELEM(i).face_node;
        face = [face,face(:,1)];
        
        for k = 1 : 6
            face_p = node(face(k,:),:);
            
%             fill3(face_p(:,1),face_p(:,2),face_p(:,3),'blue')
%             hold on
            
            plot3(face_p(:,1),face_p(:,2),face_p(:,3),'blue')
            hold on
            
            axis([0,1,0,1,0,1])
            
        end
        pause(0.01)
   %  pause
    end
    
end


axis equal

end



