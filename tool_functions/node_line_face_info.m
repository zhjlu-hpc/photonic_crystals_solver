
function  nlf = node_line_face_info(cube)

%cube = [1,1,2];

ref = [0,0,0;
    1,0,0;
    1,1,0;
    0,1,0;
    0,0,1;
    1,0,1;
    1,1,1;
    0,1,1;];

node(:,1) = ref(:,1) +  cube(1) - 1;
node(:,2) = ref(:,2) +  cube(2) - 1;
node(:,3) = ref(:,3) +  cube(3) - 1;


line_node = [
    1,2;
    2,3;
    3,4;
    4,1;
    
    1,5;
    2,6
    3,7;
    4,8;
    
    5,6;
    6,7;
    7,8;
    8,5;
    ];

line_mid = (node(line_node(:,1),:)+node(line_node(:,2),:))/2;

%%% ”“ ÷◊º‘Ú

face_node = [
    2,6,7,3;
    1,4,8,5;
    3,7,8,4;
    1,2,6,5;
    5,8,7,6;
    1,2,3,4;
    ];

face_mid = (node(face_node(:,1),:)+node(face_node(:,2),:)...
    +node(face_node(:,3),:)+node(face_node(:,4),:))/4;


nlf.node = node;
nlf.line_node = line_node;
nlf.line_mid = line_mid;
nlf.face_node = face_node;
nlf.face_mid = face_mid;

end




