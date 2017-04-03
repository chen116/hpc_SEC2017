% just get stats
clear
%load('/bj_12_routes');
load('rome_routes_60secs');
has_routes_cnt = 0;
has_routes_index = [];

cnt=size(routes,2);
for k=1:cnt
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end
clrs=distinguishable_colors(has_routes_cnt);
num_cars = length(has_routes_index);


min_time = inf;
max_time = 0;

modes = zeros(num_cars,1);
for  k=1:num_cars%length(has_routes_index)
         maps = routes{has_routes_index(k)};
         
         time =  (maps(:,3));
         
         if (max(time)>max_time)
            max_time =  max(time);
         end
         if (min(time)<min_time)
             min_time = min(time);
         end
         dif_arr= diff(time);
         modes(k)=mode(diff(time));
         
         
end
datastats(modes)
min_time
max_time
%% 
clear
tic
load('sf_routes');

has_routes_cnt = 0;
for k=1:size(routes,2);
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end
num_cars = length(has_routes_index);

for  k=1:num_cars%length(has_routes_index)
         maps = routes{has_routes_index(k)};
         cnt = 1;
         time = diff((maps(:,3)));
         cur_time = 0;
         new_route = maps(1,:);
         for kk=1:length(time)
             if cur_time >= 45
                 new_route = [new_route;maps(kk,:)];
                 cur_time = 0;
             else
                  cur_time = cur_time + time(kk);
             end
             
             
         end
         new_rome_routes{k}=new_route;
        
         

         
end






modes = zeros(num_cars,1);
for  k=1:num_cars%length(has_routes_index)
         maps = new_rome_routes{k};
         
         time =  (maps(:,3));
         dif_arr= diff(time);
         modes(k)=mode(diff(time));
         
         
         
         
         
end
datastats(modes)

routes = new_rome_routes;
save('sf_routes_60sec.mat','routes')

toc



%% force everyupdate to be 60sec
clear
clc
tic
load('sf_routes');

has_routes_cnt = 0;
for k=1:size(routes,2);
    if(~isempty(routes{k}))
        has_routes_cnt=has_routes_cnt+1;
        has_routes_index(has_routes_cnt)=k;
    end

end
num_cars = length(has_routes_index);

for  k=1:num_cars%length(has_routes_index)
         maps = routes{has_routes_index(k)};
         cnt = 1;
         time = diff((maps(:,3)));
         cur_time = 0;
         new_route =[];
         for kk=1:length(time)
             if(time(kk)==60)
                 if(size(new_route,2)==0)
                     new_route = [new_route;maps(kk,:)];
                     new_route = [new_route;maps(kk+1,:)];
                     
                 else
                     if(isempty( find(new_route(:,3)==maps(kk,3)) ))
                        new_route = [new_route;maps(kk,:)];
                     end
                     if(isempty( find(new_route(:,3)==maps(kk+1,3)) ))
                        new_route = [new_route;maps(kk+1,:)];
                     end
                 end
             end  
         end
         new_rome_routes{k}=new_route;
        
         

         
end






modes = zeros(num_cars,1);
cnt=1;
for  k=1:num_cars%length(has_routes_index)
         maps = new_rome_routes{k};
         if(size(maps,1)>0)
            time =  (maps(:,3));
         
            dif_arr= diff(time);
            modes(cnt)=mode(diff(time));
            cnt=cnt+1;
         end
         
         
         
         
         
end
datastats(modes)

routes = new_rome_routes;
save('sf_routes_60sec.mat','routes')

toc

