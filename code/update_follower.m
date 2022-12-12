function [mx_follower,dmx_follower] = update_follower(a,mxk,dmxk,uls,dt,dk,H,p,p1,p2,p3,i,s)
    mx_follower=zeros(2*H,1);
    dmx_follower=zeros(2*H,1);
    [dmx1,dmx2,ddmx1,ddmx2]=dhatx(a,mxk,dmxk,uls(1:2),i,s,H);
    mx_follower(1:2)=mxk((i-1)*2*H+1:(i-1)*2*H+2)+dt*(p1(i)*(dmx1)+p2*sign(dmx2).*abs(dmx2).^(1/p)+p3*sign(dmx2).*abs(dmx2).^(p));
    dmx_follower(1:2)=dmxk((i-1)*2*H+1:(i-1)*2*H+2)+dt*(p1(i)*(ddmx1)+p2*sign(dmx2).*abs(dmx2).^(1/p)+p3*sign(ddmx2).*abs(ddmx2).^(p));
    for l=2:H
        mx_follower((l-1)*2+1:l*2)=mx_follower((l-2)*2+1:(l-1)*2)+dk*dmx_follower((l-2)*2+1:(l-1)*2);
        dmx_follower((l-1)*2+1:l*2)=dmx_follower((l-2)*2+1:(l-1)*2)+dk*uls((l-1)*2+1:l*2);
    end
end