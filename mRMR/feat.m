function output=feat(input,io)

if (io==1)
    %Creating the position vectors from the first two columns of the table
    x_pos=input(:,1);
    y_pos=input(:,2);
    time=input(:,3);
    pressure=input(:,4);

    %The number of the lines in the data is in the "lines" variable
    sorokszama=size(input);
    lines=sorokszama(1);
    
    %F1: total distance of pen travel
    output(1)=0;
    for j=2:lines,
        output(1)=output(1)+sqrt((x_pos(j)-x_pos(j-1))^2+(y_pos(j)-y_pos(j-1))^2);
    end
    
    %F2: total time taken
    output(2)=time(lines)-time(1);
    
    %F3: number of times pen was removed
    output(3)=0;
    for j=2:lines, 
     if (pressure(j)==0) && (pressure(j-1)>0)
         output(3)=output(3)+1;
     end
    end

    %F4: width of the signature 
    output(4)=max(x_pos)-min(x_pos);
        
    %F5: height of the signature
    output(5)=max(y_pos)-min(y_pos);
        
    %F6: height divided by width
    output(6)=(max(y_pos)-min(y_pos))/(max(x_pos)-min(x_pos));
        
    %F7: standard deviation of the x values
    output(7)=std(x_pos);
        
    %F8: standard deviation of the y values
    output(8)=std(y_pos);
    
    %F9: average pen velocity in x
    % velocity = distance / time
    output(9)=0;
    for j=2:lines,
        output(9)=output(9)+(x_pos(j)-x_pos(j-1))/(time(j)-time(j-1));
    end
    output(9)=output(9)/lines-1;
    
    %F10: average pen velocity in y
    % velocity = distance / time
    output(10)=0;
    for j=2:lines,
        output(10)=output(10)+(y_pos(j)-y_pos(j-1))/(time(j)-time(j-1));
    end
    output(10)=output(10)/lines-1;
    
    %F11: number of zero velocity sample points in x
    output(11)=0;
    for j=2:lines,
        if (x_pos(j)==x_pos(j-1))
            output(11)=output(11)+1;
        end
    end
    
    %F12: number of zero velocity sample points in y
    output(12)=0;
    for j=2:lines,
        if (y_pos(j)~=y_pos(j-1))
            output(12)=output(12)+1;
        end
    end
    
    % maximum / minimum velocity x / y
    maxv_x=0;
    maxv_y=0;
    minv_x=10;
    minv_y=10;
    for j=2:lines,
        if (x_pos(j)-x_pos(j-1))/(time(j)-time(j-1))>maxv_x
            maxv_x=(x_pos(j)-x_pos(j-1))/(time(j)-time(j-1));
        end
        if (y_pos(j)-y_pos(j-1))/(time(j)-time(j-1))>maxv_y
            maxv_y=(y_pos(j)-y_pos(j-1))/(time(j)-time(j-1));
        end
        if (x_pos(j)-x_pos(j-1))/(time(j)-time(j-1))<minv_x
            minv_x=(x_pos(j)-x_pos(j-1))/(time(j)-time(j-1));
        end
        if (y_pos(j)-y_pos(j-1))/(time(j)-time(j-1))<minv_y
            minv_y=(y_pos(j)-y_pos(j-1))/(time(j)-time(j-1));
        end
    end
     
    %F13: max velocity minus average velocity in x
    output(13)=maxv_x-output(9);
    
    %F14: max velocity minus min velocity in x
    output(14)=maxv_x-minv_x;
    
    %F15: max velocity minus average velocity in y
    output(15)=maxv_y-output(10);
    
    %F16: max velocity minus min velocity in y
    output(16)=maxv_y-minv_y;
    
    %F17: max pen velocity in x minus min pen velocity in y
    output(17)=maxv_x-minv_y;
    
    %F18: average pen acceleration in x
    % acceleration: (v2-v1)/t
    output(18)=0;
    for j=3:lines,
        output(18)=output(18)+((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) - (x_pos(j-1)-x_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
    end
    output(18)=output(18)/lines-2;
    
    %F19: average pen velocity in y
    % acceleration: (v2-v1)/t
    output(19)=0;
    for j=3:lines,
        output(19)=output(19)+((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) - (y_pos(j-1)-y_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
    end
    output(19)=output(19)/lines-2;
    
    %F20: number of zero acceleration sample points in x
    %ture, if the velocity doesnt change
    output(20)=0;
    for j=3:lines,
        if (((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) == (x_pos(j-1)-x_pos(j-2))))
            output(20)=output(20)+1;
        end
    end
    
    %F21: number of zero acceleration sample points in x
    output(21)=0;
    for j=3:lines,
        if (((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) == (y_pos(j-1)-y_pos(j-2))))
            output(21)=output(21)+1;
        end
    end
    
    % maximum / minimum acceleration x / y
    % acceleration: (v2-v1)/t
    maxa_x=0;
    maxa_y=0;
    mina_x=10;
    mina_y=10;
    for j=3:lines,
        if ((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) - (x_pos(j-1)-x_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2)) > maxa_x
            maxa_x=((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) - (x_pos(j-1)-x_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
        end
        if ((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) - (y_pos(j-1)-y_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2)) > maxa_y
            maxa_y=((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) - (y_pos(j-1)-y_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
        end
        if ((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) - (x_pos(j-1)-x_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2)) < mina_x
            mina_x=((x_pos(j)-x_pos(j-1))/(time(j)-time(j-1)) - (x_pos(j-1)-x_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
        end
        if ((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) - (y_pos(j-1)-y_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2)) < mina_y
            mina_y=((y_pos(j)-y_pos(j-1))/(time(j)-time(j-1)) - (y_pos(j-1)-y_pos(j-2))/(time(j-1)-time(j-2))) / (time(j)-time(j-2));
        end
    end
     
    %F22: max acceleration minus average acceleration in x
    output(22)=maxa_x-output(18);
    
    %F23: max acceleration minus min acceleration in x
    output(23)=maxa_x-mina_x;
    
    %F24: max acceleration minus average acceleration in y
    output(24)=maxa_y-output(19);
    
    %F25: max acceleration minus min acceleration in y
    output(25)=maxa_y-mina_y;
    
    %F26: max pen acceleration in x minus min pen acceleration in y
    output(26)=maxa_x-mina_y;
    
    %F27: number of times pen passes though the midline
    %midline: the line with the same distance from the lowest and highest point
    output(27)=0;
    midline=(max(y_pos)+min(y_pos))/2;
    for j=2:lines,
    if (midline > y_pos(j-1) && midline < y_pos(j)) || (midline < y_pos(j-1) && midline > y_pos(j))
        output(27)=output(27)+1;
    end
    end
          
    %F28: points comprising the image
    %it equals to the number of the datalines? im not sure
    output(28)=lines;
    
    %F29: sum of x coordinate values
    output(29)=sum(x_pos);
        
    %F30: sum of y coordiate values
    output(30)=sum(y_pos);
        
    %F31: horizontal centralness
    output(31)=sum(x_pos)/lines;
        
    %F32: vertical centralness
    output(32)=sum(y_pos)/lines;



else
    output(1:32)=0;
        
end
        