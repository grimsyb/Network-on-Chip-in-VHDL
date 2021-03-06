
%draw(0,120*rand(96,1));

function [NS,EW,NS_busy, EW_busy, local_busy_in, blinking] = draw(count,x,NS,EW,NS_busy, EW_busy, local_busy_in,blinking)

%t = cputime; 

    name{1,1} = {'0000','proc'};
    name{2,1} = {'0001','mem'};
    name{3,1} = {'0010',''};
    name{4,1} = {'0011','mem'};
    name{1,2} = {'0100','mem'};
    name{2,2} = {'0101','proc'};
    name{3,2} = {'0110',''};
    name{4,2} = {'0111',''};
    name{1,3} = {'1000','proc'};
    name{2,3} = {'1001','proc'};
    name{3,3} = {'1010',''};
    name{4,3} = {'1011',''};
    name{1,4} = {'1100','switches'};
    name{2,4} = {'1101',''};
    name{3,4} = {'1110',''};
    name{4,4} = {'1111','mem'};


    if(length(x) >= 48)
        %figure(1);
        clear figure
        hold on
        scale = 1;
        axis([10*scale,scale*140,-scale*130,-10*scale]);
        axis off

        
        
        facecolor(1,:) = [0.6,0.6,0.6]; %node
        facecolor(2,:) = [1,1,1]; %not busy
        facecolor(3,:) = [1,6/7,0]; %traffic 1
        facecolor(4,:) = [1,5/7,0]; %traffic 2
        facecolor(5,:) = [1,4/7,0]; %traffic 3
        facecolor(6,:) = [1,3/7,0]; %traffic 4
        facecolor(7,:) = [1,2/7,0]; %traffic 5
        facecolor(8,:) = [1,1/7,0]; %traffic 6
        facecolor(9,:) = [1,0,0]; %traffic 7

        x = cast(x,'int8');
        x = cast(x,'double');
        
        %x = min(floor((x+30)/32)+2,5);
        %x = min(floor((x+12)/14)+2,9);
        
        %turn into colours
        
        x(1:48) = min(floor((x(1:48)+16)/18)+2,9); %packets
            
       x(49:128) = min(floor((x(49:128)+2)/4)+2,9); %busys

%disp('constants and colours'); e = cputime-t

        if(nargin > 2)
        %have already drawn the figure
        
%t = cputime;

            draw2(x,NS,EW,facecolor,scale,NS_busy,EW_busy,local_busy_in,name,blinking,count)

%disp('draw not first'); e = cputime-t       
        else
        %have not drawn figure yet
%t = cputime;      
            %char_text = text(scale*40,-scale*5,num2str(x));
            
            for i = 1:4         %x
                for j = 1:4     %y
                    local_busy_in(i,j) = rectangle('Position',[scale*(30*i),-scale*(30*j),10*scale,10*scale],'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+96),:));
                    text(scale*(30*i)+1,-scale*(30*j)+6,name{i,j});
                end
            end

            %NS
            for i = 1:4         %x
                for j = 1:3     %y
                    NS(j,i,1) = rectangle('Position',[scale*(30*i+3),-scale*(30*j+20),scale*2,scale*20],'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))),:));
                    quiver(scale*(30*i+4),-scale*(30*j+20)+2,0,scale*16,'b','LineWidth',1);
                    NS(j,i,2) = rectangle('Position',[scale*(30*i+5),-scale*(30*j+20),scale*2,scale*20],'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+1),:));
                    quiver(scale*(30*i+6),-scale*(30*j)-2,0,-scale*16,'b','LineWidth',1);
                end
            end

            %EW
            for i = 1:3         %x
                for j = 1:4     %y
                    EW(j,i,1) = rectangle('Position',[scale*(30*i+10),-scale*(30*j-5),scale*20,scale*2],'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+24),:));
                    quiver(scale*(30*i+10)+2,-scale*(30*j-6),scale*16,0,'b','LineWidth',1);
                    EW(j,i,2) = rectangle('Position',[scale*(30*i+10),-scale*(30*j-3),scale*20,scale*2],'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+25),:));
                    quiver(scale*(30*i+30)-2,-scale*(30*j-4),-scale*16,0,'b','LineWidth',1);
                end
            end

            %busy signals
            
            %NS busy
            for i = 1:4         %x
                for j = 1:3     %y
                    NS_busy(j,i,1) = rectangle('Position',[scale*(30*i+1),-scale*(30*j)-2*scale,scale*8,scale*2],'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+1+48),:));
                    NS_busy(j,i,2) = rectangle('Position',[scale*(30*i+1),-scale*(30*j+20),scale*8,scale*2],'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+48),:));

                end
            end

            %EW busy
            for i = 1:3         %x
                for j = 1:4     %y
                    EW_busy(j,i,1) = rectangle('Position',[scale*(30*i+10),-scale*(30*j-1),scale*2,scale*8],'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+24+48),:));
                    EW_busy(j,i,2) = rectangle('Position',[scale*(30*(i+1)-2),-scale*(30*j-1),scale*2,scale*8],'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+25+48),:));
                end
            end
            
            
            
            %toggle blinking rectangle
            blinking = rectangle('Position',[25*scale,-15*scale,1*scale,1*scale],'FaceColor',mod(count,2)*[0.8,0.8,0.8]+[0.1,0.1,0.1]);
            
            
            
            hold off
%disp('draw first'); e = cputime-t            
        end        
    else
        length(x)
    end
%t = cputime;
    drawnow;
%disp('drawnow'); e = cputime-t

end

function draw2(x,NS,EW,facecolor,scale, NS_busy,EW_busy,local_busy_in,name, blinking,count)

hold on
    %set(char_text,'Text',num2str(x));

    set(blinking,'FaceColor',mod(count,2)*[0.8,0.8,0.8]+[0.1,0.1,0.1]);
    
    for i = 1:4         %x
        for j = 1:4     %y
            set(local_busy_in(i,j),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+96),:));
            %text(scale*(30*i)+1,-scale*(30*j)+8,name{i,j});
        end
    end
    
    %NS
    for i = 1:4         %x
        for j = 1:3     %y
            %if(get(NS(j,i,1) ~= facecolor(x(1+2*((j-1)+3*(i-1))),:)))
                set(NS(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))),:));
            %end
            %if(get(NS(j,i,2) ~= facecolor(x(1+2*((j-1)+3*(i-1))+1),:)))
                set(NS(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+1),:));
            %end
        end
    end

    %EW
    for i = 1:3         %x
        for j = 1:4     %y
            %if(get(EW(j,i,1) ~= facecolor(x(1+2*((j-1)+4*(i-1))+24),:)))
                set(EW(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+24),:));
            %end
            %if(get(EW(j,i,2) ~= facecolor(x(1+2*((j-1)+4*(i-1))+25),:)))
                set(EW(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+25),:));
            %end
        end
    end

    %busy signals

    %NS busy
    for i = 1:4         %x
        for j = 1:3     %y
            %if(get(NS_busy(j,i,1) ~= facecolor(x(1+2*((j-1)+3*(i-1))+48),:)))
                set(NS_busy(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+48),:));
            %end
            %if(get(NS_busy(j,i,2) ~= facecolor(x(1+2*((j-1)+3*(i-1))+1+48),:)))
                set(NS_busy(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+1+48),:));
            %end
        end
    end

    %EW busy
    for i = 1:3         %x
        for j = 1:4     %y
            %if(get(EW_busy(j,i,1) ~= facecolor(x(1+2*((j-1)+4*(i-1))+24+48),:)))
                set(EW_busy(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+24+48),:));
            %end
            %if(get(EW_busy(j,i,2) ~= facecolor(x(1+2*((j-1)+4*(i-1))+25+48),:)))
                set(EW_busy(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+25+48),:));
            %end
        end
    end
  
%     
%     for i = 1:4         %x
%         for j = 1:3     %y
%             %if(get(NS(j,i,1),'FaceColor') ~= facecolor(x(1+2*((j-1)+3*(i-1)))))
%                 set(NS(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))),:));
%             %end
%             %quiver(scale*(20*i+4),-scale*(20*j+10),0,scale*10,'b','LineWidth',1);
%             %if(get(NS(j,i,2),'FaceColor') ~= facecolor(x(1+2*((j-1)+3*(i-1))+1)))
%                 set(NS(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+3*(i-1))+1),:));
%             %end
%             %quiver(scale*(20*i+6),-scale*(20*j),0,-scale*10,'b','LineWidth',1);
%         end
%     end
% 
%     %EW
%     for i = 1:3         %x
%         for j = 1:4     %y
%             %if(get(EW(j,i,1),'FaceColor') ~= facecolor(x(1+2*((j-1)+4*(i-1))+24),:))
%                 set(EW(j,i,1),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+24),:));
%                 %quiver(scale*(20*i+10),-scale*(20*j-6),scale*10,0,'b','LineWidth',1);
%             %end
%             
%             %if(get(EW(j,i,2),'FaceColor') ~= facecolor(x(1+2*((j-1)+4*(i-1))+25),:))
%                 set(EW(j,i,2),'FaceColor',facecolor(x(1+2*((j-1)+4*(i-1))+25),:));
%                 %quiver(scale*(20*i+20),-scale*(20*j-4),-scale*10,0,'b','LineWidth',1);
%             %end
%             
%         end
%     end

hold off




end
