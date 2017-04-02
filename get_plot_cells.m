function [ output_args ] = get_plot_cells( centers,r,h,base )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(centers,1)
   
    x=r*[-1 -0.5 0.5 1 0.5 -0.5 -1]+centers(i,2);
    y=r*sqrt(3)*[0 -0.5 -0.5 0 0.5 0.5 0]+centers(i,1);
    plot(x,y,'-r','Linewidth',1)
    hold on
    plot(centers(i,2),centers(i,1),'rd')
    hold on
   
    ang=0:0.05:2*pi; 
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(centers(i,2)+xp,centers(i,1)+yp,'-b');
    hold on
end



    hold off
   lon_max = r*(1+base*1.5+1+0.5)
   lat_max=r*(1+2*base*h+1)
   xlabel('km')
   ylabel('km')
   xlim([0 lon_max])
   ylim([0 lat_max])

output_args = 1;

end

