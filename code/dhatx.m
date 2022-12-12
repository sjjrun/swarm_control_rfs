function [dmx1,dmx2,ddmx1,ddmx2]=dhatx(a,mx,dmx,ul,i,s,H)
    dmx1=zeros(2,1);
    dmx2=zeros(2,1);
    ddmx1=zeros(2,1);
    ddmx2=zeros(2,1);
    for j=1:length(a)
        if j~=i
                dmx1=dmx1+a(j)*dmx((j-1)*2*H+1:(j-1)*2*H+2);
                dmx2=dmx2+a(j)*(mx((i-1)*2*H+1:(i-1)*2*H+2)-mx((j-1)*2*H+1:(j-1)*2*H+2));
                ddmx2=ddmx2+a(j)*(dmx((i-1)*2*H+1:(i-1)*2*H+2)-dmx((j-1)*2*H+1:(j-1)*2*H+2));
                if j==s
                    ddmx1=ddmx1+ul;
                end
        end
    end
end