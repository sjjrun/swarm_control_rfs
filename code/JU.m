function cost = JU(u,u_min,u_max)
cost=0;
for i = size(u)
    if u(i)>u_max(i) || u(i)<u_min(i)
        cost=10000;
        return
    end
    cost=cost+log((-u_min(i)*u_max(i))/((u(i)-u_min(i))*(u_max(i)-u(i))))-(u_min(i)+u_max(i))*u(i)/(u_min(i)*u_max(i));
end
% cost=log((-u_min'*u_max)/(norm(u-u_min)*norm(u_max-u)))-(u_min+u_max)'*u/(u_min'*u_max);
cost=cost;
end