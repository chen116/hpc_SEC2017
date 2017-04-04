function [ is_in_hex ] = get_in_hex( coor,center )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

h=0.25;

v=0.25*(3)^.5; 

x= abs(coor(2)-center(2));
y= abs(coor(1)-center(1));
if( x>2*h || y>v)
    is_in_hex = 0;
else
    if h*y-v*x>=0 
        is_in_hex = 1;
    else
        is_in_hex = 0;
    end
end



end

