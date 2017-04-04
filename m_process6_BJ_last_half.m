
clear
clc
close all
tic
format long

clrs=distinguishable_colors(2);
%load('rome_routes');
%load('sf_routes');
load('bj_routes');
% 41.915220, 12.48
% 41.883314, 12.48
% 41.915220, 12.522653
% 41.883314,12.522653
bl_lat = 41.883314;
tl_lat = 41.915220;
tr_lon = 12.522653;
tl_lon = 12.48;

% 37.7638,-122.4165
% 37.7962,-122.4165
% 37.7638,-122.4565
% 37.7962,-122.4565

bl_lat = 37.7638;
tl_lat = 37.7962;
tr_lon = -122.4165;
tl_lon = -122.4565;
% 


tl_lon = 116.40369;
bl_lat = 39.94119;
tl_lat = 39.97269;
tr_lon = 116.44481;


r = 0.5;
h = sqrt(3)/2;
base = 3;
centers = get_cell_centers( base,r,h );
num_nodes=size(centers,1);
[ lat_scale , lon_scale ] = get_lat_lon_scale( bl_lat,tl_lat,tl_lon,tr_lon );
[ has_routes_index ] = get_has_routes_index( routes );
[ min_time, max_time ] = get_min_max_time( routes, has_routes_index );

min_time =  floor(max_time+min_time/2)+1;
max_time =  max_time;

min_date = datestr(min_time/86400 + datenum(1970,1,1))
max_date = datestr(max_time/86400 + datenum(1970,1,1))

time_slot = 5;
total_pred = 0;
correct_pred = 0;

num_cars = length(has_routes_index);
car = zeros(num_cars,5); % pre_location[lat lon], pre_timestamp, speed,  going_to

%figure
for j = min_time:max_time
    if mod(j,100000)==0
        datestr(j/86400 + datenum(1970,1,1))
        correct_pred
        total_pred 
        suc_rate = correct_pred/total_pred 
    end
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
                elseif(j-car(k,3)>60)
                    car(k,:) = [lat lon j 0 0];    
                else
                    pre_coor = [car(k,1) car(k,2)];
                    speed = pdist([coor; pre_coor],'euclidean')/(j-car(k,3));                                                         
                    if (pre_coor(1)-coor(1)~=0 && pre_coor(2)-coor(2)~=0   )%if (sum(pre_coor-[lat lon])~=0)
                        % check if prediction is correct:
                        if(car(k,5)>0) 
                            im_at = get_belong_where(coor,centers);
                            total_pred = total_pred +1;  
                            if(im_at ==car(k,5) )
                               correct_pred = correct_pred + 1; 
                               %plot([coor(2) pre_coor(2)],[ coor(1) pre_coor(1)],'-o','Color',clrs(1,:),'LineWidth',3)
                               %hold on
                            else
                               %plot([coor(2) pre_coor(2)],[ coor(1) pre_coor(1)],'-o','Color',clrs(2,:),'LineWidth',3)
                               %hold on
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



%get_plot_cells( centers,r,h,base )



toc


disp('final')
correct_pred
total_pred 
suc_rate = correct_pred/total_pred 
disp(sprintf ( '\n') )

%savefig('sf_cars_t30.fig')
