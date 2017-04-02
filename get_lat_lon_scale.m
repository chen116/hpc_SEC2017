function [ lat_scale lon_scale ] = get_lat_lon_scale( bl_lat,tl_lat,tl_lon,tr_lon )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
tr_lat = tl_lat ;
bl_lon = tl_lon;
br_lat = bl_lat;
br_lon = tr_lon ;


tl = [tl_lat tl_lon ];
tr =  [tr_lat tr_lon];
bl = [bl_lat bl_lon ];
br = [br_lat br_lon];


lon_dist = lldistkm(tl,tr);
lat_dist = lldistkm(tl,bl);
lat_scale = lat_dist/(tl_lat-bl_lat);
lon_scale = lon_dist/(tr_lon-tl_lon);

end

