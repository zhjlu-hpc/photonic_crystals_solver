
function NO = find_node_NO(all_node, node)

ss(:,1) = all_node(:,1) - node(1);
ss(:,2) = all_node(:,2) - node(2);
ss(:,3) = all_node(:,3) - node(3);

sss = sum(abs(ss),2);

NO = find(sss == 0);

end
