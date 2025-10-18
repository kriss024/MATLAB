function [ wynik ] = dodajOpoznienie( vec, t)
    l=length(vec);
    if t>=1
        pierwszy=vec(1,1);
        v_delta=[];
        dopel=zeros(t,1);
        for i=1:2*t
            delta=vec(i,1)-vec(i+1,1);
            v_delta=[v_delta,delta];
        end
        avg= mean(v_delta);
        dd=length(dopel);
        elem=pierwszy+avg;
        for i=dd:-1:1;
           dopel(i,1)=elem;
           elem=dopel(i,1)+avg;
        end     
        temp=[dopel;vec];
        wynik=temp(1:l,1);
    else
       wynik=vec;
    end
end

