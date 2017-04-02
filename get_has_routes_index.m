function [ has_routes_index ] = get_has_routes_index( routes )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
cnt=size(routes,2);

has_routes_cnt = 0;
has_routes_index = [];
for k=1:cnt
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end


end

