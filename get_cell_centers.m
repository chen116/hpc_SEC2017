function [ centers ] = get_cell_centers( base,r,h )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


cnt = 1;


for i=1:base
    if mod(i,2)==0
        %even clos
        num=base;
        for j = 1:num
           centers(cnt,:) = r*[1+h+2*(j-1)*h,i*1.5+0.5]; 
           cnt = cnt +1;
        end  
    else
        %odd clos
        num=base-1;
        for j = 1:num
           centers(cnt,:) = r*[1+2*(j)*h,i*1.5+0.5];
           cnt = cnt +1;
        end          

    end
end
       


end

