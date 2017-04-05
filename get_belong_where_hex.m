function [ belong_to ] = get_belong_where_hex( coor,centers )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
found = 0;
kkk=1;
num_nodes=size(centers,1);
while kkk<=num_nodes && found ==0
       found = get_inside_hex(coor,centers(kkk,:));
       if found ==1
           belong_to = kkk;  
       end
       kkk=kkk+1;
end

if found == 0;
    dis = zeros(num_nodes,1);
    for kkk = 1:num_nodes
            dis(kkk) =   pdist([coor;centers(kkk,:)],'euclidean') ;
    end
    [v , belong_to] = min(dis);   
end

end

