function [ min_time, max_time ] = get_min_max_time( routes, has_routes_index )



%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
num_cars = length(has_routes_index);
min_time = inf;
max_time = 0;


for  k=1:num_cars%length(has_routes_index)
    
     maps = routes{has_routes_index(k)};
     time_for_min_max =  (maps(:,3));
     if (max(time_for_min_max)>max_time)
        max_time =  max(time_for_min_max);
     end
     if (min(time_for_min_max)<min_time)
         min_time = min(time_for_min_max);
     end
     
end

end

