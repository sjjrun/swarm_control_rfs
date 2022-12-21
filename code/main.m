%% 初始化
close all
clear
nk=6;
nd=3;
% wk=[1.1 1 0.9];
% mk=[10 10 10; 35 25 15];
% dmk=[0 0 0; 0 0 0];
% pk=[1 1 1; 1 1 1];
% uk=[0 0 0; 0 0 0];
wk=[1 1 1 1 1 1];
mk=[5 5 5 10 10 10; 35 25 15 35 25 15];
dmk=[0 0 0 0 0 0; 0 0 0 0 0 0];
pk=[1 1 1 1 1 1 ; 1 1 1 1 1 1];
uk=[0 0 0 0 0 0; 0 0 0 0 0 0];
%% initial condition for JD1
wd=[2.1 2.0 1.99];
md=[90 80 80; 25 45 5];
%
%% initial condition for JD2
% wd=[2 2 2];
% md=[90 80 80; 25 45 5];
%
pd=[1 1 1; 1 1 1];
mc=[30 60 30 60 45; 42 42 8 8 25];
dc=[3 3 3 3 3];
x=[0 100];
y=[0 50];
kmax=100;
dt=0.001;
dk=1;
H=5;
w=kron(ones(kmax,1),wk);
ul=kron(ones(H,1),uk);
u=kron(ones(kmax,1),uk);
ml=kron(ones(H,1),mk);
dml=kron(ones(H,1),dmk);
mx=zeros(2*H*nk,nk);
for i=1:nk
    mx((i-1)*2*H+1:i*2*H,i)=ml(:,i);
end
dmx=kron(ones(nk,1),dml);
m=kron(ones(kmax,1),mk);
dm=kron(ones(kmax,1),dmk);
% A=[1 1 1;1 1 1; 1 1 1];
A=[0 1 0 1 0 0; 1 0 1 0 1 0; 0 1 0 0 0 1; 1 0 0 0 1 0;0 1 0 1 0 1; 0 0 1 0 1 0];
p=0.6;
p1=1./(sum(A'));
p2=-60;
p3=-60;
umin=[-3;-3];
umax=[5;5];
num_surf=50;
[X,Y]=meshgrid(linspace(x(1), x(2), num_surf),linspace(y(1), y(2), num_surf/2));
Z=zeros(num_surf/2,num_surf);
%% 计算

for k=1:kmax
    k
    % 观测器
    [mx,dmx]=observer(A,mx,dmx,ul,p,p1,p2,p3,dt,dk,H,w(k,:));
    % 控制器
    ul=controller(ul,w(k,:),mx,dmx,pk,wd,md,pd,mc,dc,H,umin,umax,dk,k);
    % 剪枝
    [A,w(k+1,:),mx,dmx,pk,ul,p1]=cut(A,w(k,:),mx,dmx,wd,md,pk,pd,ul,p1,H);

    % 寄存数据
    for i=1:nk
        m((k-1)*2+1:k*2,i)=mx((i-1)*2*H+1:(i-1)*2*H+2,i);
        dm((k-1)*2+1:k*2,i)=dmx((i-1)*2*H+1:(i-1)*2*H+2,i);
    end
    u((k-1)*2+1:k*2,:)=ul(1:2,:);
    
    for i=1:num_surf/2
        for j=1:num_surf
            zwk=[1 w(k,:)];
            zmk=[[X(i,j);Y(i,j)] m((k-1)*2+1:k*2,:)];
            zpk=[[1;1] pk];
            Z(i,j) = JD1(zwk,zmk,zpk,wd,md,pd,1)+JC(zmk(:,1),[0;0],mc,dc);
        end
    end
    

    figure(1)
    scatter(m((k-1)*2+1,:),m(k*2,:),'filled');
    hold on
    scatter(mc(1,:),mc(2,:));
    hold on
    scatter(md(1,:),md(2,:));
    axis([x(1) x(2) y(1) y(2)]);
    axis equal
    hold off

    figure(2)
    surf(X,Y,Z,'FaceAlpha',0.7);
    view(3);
    axis([x(1) x(2) y(1) y(2)]);
%     axis equal
    axis tight
    hold off


end
% save data_alpha.mat

% save data_sigma.mat