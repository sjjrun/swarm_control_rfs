function ul = controller(ul,wk,mx,dmx,pk,wd,md,pd,mc,dc,H,umin,umax,dk,k)
    ul=[ul(3:end,:);zeros(2,size(ul,2))];
    option = optimoptions('fminunc','MaxIterations',5000,'Display','off','MaxFunctionEvaluations',5000,'StepTolerance',1e-3);
    for i=1:length(wk)
        if wk(i)~=0 && wk(i)<0.8*max(wd)
            ul(:,i)=fminunc(@costfun,ul(:,i),option,wk,mx((i-1)*2*H+1:i*2*H,:),dmx((i-1)*2*H+1:i*2*H,:),pk,wd,md,pd,mc,dc,H,i,umin,umax,dk,k);
        end
    end
end