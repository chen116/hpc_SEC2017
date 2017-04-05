function [ going_to ] = get_prediction_hex( pre_coor,coor,centers,time_slot,speed,r )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    going_to = 0;
    lon=coor(2);
    lat=coor(1);
    clrs=distinguishable_colors(2);
    num_nodes=size(centers,1);
    for kk = 1:size(centers,1)
        center = centers(kk,:);
          %if(pdist([coor; center],'euclidean')<r && pdist([pre_coor; center],'euclidean')<r)
          if(get_inside_hex(coor,center) && get_inside_hex(pre_coor,center))
            if(lon == pre_coor(2))
                x_inter(1) = sqrt(r^2-(lon-center(2))^2)+center(1);
                x_inter(2) = -sqrt(r^2-(lon-center(2))^2)+center(1);
                itersecs = [x_inter(1) lon ;x_inter(2) lon ];
            else

                a =  (lat - pre_coor(1)) / (lon - pre_coor(2));
                b = lat-a*lon;
                x_inter = roots([1+a^2 -2*center(2)+2*a*(b-center(1)) center(2)^2+(b-center(1))^2-r^2 ]);
                itersecs = [a*x_inter(1)+b x_inter(1) ;a*x_inter(2)+b x_inter(2) ];
            end

             if(isreal(x_inter))
                for iter = 1:2
                    if( pdist([itersecs(iter,:); pre_coor],'euclidean')==...
                            pdist([coor; pre_coor],'euclidean')+...
                            pdist([coor; itersecs(iter,:)],'euclidean'))

                       heading_toward = itersecs(iter,:);

                        if(pdist([coor; heading_toward],'euclidean')/speed<time_slot)
                            %heading_toward = (coor-pre_coor)./(j-car(k,3)).*time_slot + coor; %itersecs(iter,:);
                            %x= coor(2)+(coor(2)-pre_coor(2));% heading_toward(2)-center(2);
                            %y =coor(1)+(coor(1)-pre_coor(1));% heading_toward(1)-center(1);
                            %new_coor = (coor-pre_coor)./(j-car(k,3)).*time_slot+coor;
                            new_coor = coor*2-pre_coor;
        %                                                 base_dis = 99999;
        %                                                 for kkk = 1:num_nodes
        %                                                    % if (kkk~=kk)
        %                                                         dis =  pdist([new_coor;centers(kkk,:)],'euclidean') ;
        %                                                         if (dis < base_dis   )
        %                                                             base_dis = dis;
        %                                                             going_to = kkk;
        % 
        %                                                         end
        %                                                     %end
        % 
        %                                                 end

%                             dis = zeros(num_nodes,1);
%                             for kkk = 1:num_nodes
%                                dis(kkk) =  pdist([new_coor;centers(kkk,:)],'euclidean') ;
%                             end
%                             [v , going_to] = min(dis);
                            
                            going_to = get_belong_where_hex(new_coor,centers);
                            
                            
%                            if( ~(going_to==4 || kk==4) )
%                                going_to = 0;
%                            else
% 
% 
% %                                                             plot([new_coor(2) coor(2)  ],[new_coor(1) coor(1) ],'-d','Color',clrs(1,:),'MarkerSize',5)
% %                                                             hold on                                                    
% %                                                             plot([coor(2) pre_coor(2)],[coor(1) pre_coor(1)],'-*','Color',clrs(1,:))
% %                                                             hold on
% %                                                             plot([new_coor(2) heading_toward(2) ],[new_coor(1) heading_toward(1) ],'-d','Color',clrs(1,:),'MarkerSize',5)
% %                                                             hold on                                                    
% %                                                             plot([heading_toward(2) coor(2) pre_coor(2)],[heading_toward(1) coor(1) pre_coor(1)],'-*','Color',clrs(1,:))
% %                                                             hold on
% %                                                             plot([coor(2) pre_coor(2)],[coor(1) pre_coor(1)],'-o','Color',clrs(1,:))
% %                                                             hold on
%                            end

                        else
                            
                             going_to = kk;                   
                            
                        end


                    end
                end

             end

        end % <0.5
    end
end

