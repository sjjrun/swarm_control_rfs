function [mx,dmx] = observer(A,mx,dmx,ul,p,p1,p2,p3,dt,dk,H,wk)
t=0;
while t<=dk
    for s=1:size(mx,2)
        if wk(s)~=0
            [mx_leader,dmx_leader] = update_leader(mx((s-1)*2*H+1:s*2*H,s),dmx((s-1)*2*H+1:s*2*H,s),ul(:,s),dt,dk,H);
            mx((s-1)*2*H+1:s*2*H,s)=mx_leader;
            dmx((s-1)*2*H+1:s*2*H,s)=dmx_leader;
        end
        %跟随者观测值更新
        for i=1:size(mx,2)
            if i~=s && wk(i)~=0
                [mx_follower,dmx_follower] = update_follower(A(i,:),mx(:,s),dmx(:,s),ul(:,s),dt,dk,H,p,p1,p2,p3,i,s);
                mx((i-1)*2*H+1:i*2*H,s)=mx_follower;
                dmx((i-1)*2*H+1:i*2*H,s)=dmx_follower;
            end
        end
    end
    t=t+dt;
end
end