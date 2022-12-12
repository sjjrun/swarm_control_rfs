function cost = costfun(uli,wk,hmx,hdmx,pk,wd,md,pd,mc,dc,H,i,umin,umax,dk,k)
    cost=0;
%     if k==1
%         cost=cost+JD1(wk,hmx(1:2,:),pk,wd,md,pd)+0*JC(hmx(1:2,i),mc,dc)+0*JU(uli(1:2),umin,umax);
%         return
%     end
    [hmx(:,i),hdmx(:,i)] = update_leader(hmx(:,i),hdmx(:,i),uli,dk,dk,H);

    for l=1:H
        cost=cost+JD1(wk,hmx((l-1)*2+1:l*2,:),pk,wd,md,pd,i)+JC(hmx((l-1)*2+1:l*2,i),pk(:,i),mc,dc)+JU(uli((l-1)*2+1:l*2),umin,umax)+JU(hdmx((l-1)*2+1:l*2,i),[-5;-5],[5;5]);
    end
end