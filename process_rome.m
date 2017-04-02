
clear
clc
close all
tic
format long

clrs=distinguishable_colors(2);
load('rome_routes');
% 41.915220, 12.48
% 41.883314, 12.48
% 41.915220, 12.522653
% 41.883314,12.522653


bl_lat = 41.883314;
tl_lat = 41.915220;
tr_lon = 12.522653;
tl_lon = 12.48;



r = 0.5;
h = sqrt(3)/2;
base = 3;
centers = get_cell_centers( base,r,h );
num_nodes=size(centers,1);
[ lat_scale , lon_scale ] = get_lat_lon_scale( bl_lat,tl_lat,tl_lon,tr_lon );
[ has_routes_index ] = get_has_routes_index( routes );
[ min_time, max_time ] = get_min_max_time( routes, has_routes_index );

min_time
max_time 

time_slot = 5;
total_pred = 0;
correct_pred = 0;

num_cars = 1%length(has_routes_index);
car = zeros(num_cars,5); % pre_location[lat lon], pre_timestamp, speed,  going_to

figure
for j = min_time:max_time
%     if mod(j,10000)==0
%         j
%     end
     for  k=1:num_cars%length(has_routes_index)
        maps = routes{has_routes_index(k)};
        time =  (maps(:,3));
        if(~isempty(find(time==j, 1)))
            index = find(time==j, 1);
            lon = (maps(index,2)-tl_lon).*lon_scale;
            lat = (maps(index,1)-bl_lat).*lat_scale;
            coor = [lat lon];
            going_to =0;
            
            del_row = true(1,size(routes{has_routes_index(k)},1));
            del_row(index)=false;
            routes{has_routes_index(k)}=routes{has_routes_index(k)}(del_row,:);
            clear('routes{has_routes_index(k)}');                        
            
                if(k==0)
                    car(k,:) = [lat lon j 0 0];
                else
                    pre_coor = [car(k,1) car(k,2)];
                    speed = pdist([coor; pre_coor],'euclidean')/(j-car(k,3));                                                         
                    if (pre_coor(1)-coor(1)~=0 && pre_coor(2)-coor(2)~=0 )%if (sum(pre_coor-[lat lon])~=0)
                        % check if prediction is correct:
                        if(car(k,5)>0)   
                            dis = zeros(num_nodes,1);
                            for kkk = 1:num_nodes
                                    dis(kkk) =   pdist([coor;centers(kkk,:)],'euclidean') ;
                            end
                            [v , im_at] = min(dis);
                            total_pred = total_pred +1;  
                            if(im_at ==car(k,5) )
                               correct_pred = correct_pred + 1; 
                               plot([coor(2) pre_coor(2)],[ coor(1) pre_coor(1)],'-o','Color',clrs(1,:),'LineWidth',3)
                               hold on
                            else
                               plot([coor(2) pre_coor(2)],[ coor(1) pre_coor(1)],'-o','Color',clrs(2,:),'LineWidth',3)
                               hold on
                            end
                            
                                   
                        end
                        % make prediction
                        [ going_to ] = get_prediction( pre_coor,coor,centers,time_slot,speed,r );
                            
                    end  

                    car(k,:) = [lat lon j speed going_to];
                end
        end





     end
end



get_plot_cells( centers,r,h,base )



toc



correct_pred
total_pred 
suc_rate = correct_pred/total_pred 
disp(sprintf ( '\n') )

%savefig('rome_313cars.fig')
