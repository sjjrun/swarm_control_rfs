function [mx_leader,dmx_leader] = update_leader(mx,dmx,uls,dt,dk,H)
    mx_leader=zeros(2*H,1);
    dmx_leader=zeros(2*H,1);
    mx_leader(1:2)=mx(1:2)+dt*dmx(1:2);
    dmx_leader(1:2)=dmx(1:2)+dt*uls(1:2);
    for l=2:H
        mx_leader((l-1)*2+1:l*2)=mx_leader((l-2)*2+1:(l-1)*2)+dk*dmx_leader((l-2)*2+1:(l-1)*2);
        dmx_leader((l-1)*2+1:l*2)=dmx_leader((l-2)*2+1:(l-1)*2)+dk*uls((l-1)*2+1:l*2);
    end
end