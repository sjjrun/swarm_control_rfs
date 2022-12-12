close all
clear all
A=[0 1 0 1 0 0; 1 0 1 0 1 0; 0 1 0 0 0 1; 1 0 0 0 1 0;0 1 0 1 0 1; 0 0 1 0 1 0];
p=0.6;
p1=1./(sum(A')+1);
p2=-20;
p3=-20;
dt=0.001;
dk=1;
H=5;
wk=[1 1 1 1 1 1];
load('data_mx9.mat');
load('data_dmx9.mat');
load('data_ul9.mat');


t=9;
ts=t:dt:10;
ts=kron(ones(length(wk),1),ts);
index=1;
mx1=zeros(size(A,1),length(ts));
mx2=zeros(size(A,1),length(ts));
mx3=zeros(size(A,1),length(ts));
mx4=zeros(size(A,1),length(ts));
mx5=zeros(size(A,1),length(ts));
mx6=zeros(size(A,1),length(ts));
my1=zeros(size(A,1),length(ts));
my2=zeros(size(A,1),length(ts));
my3=zeros(size(A,1),length(ts));
my4=zeros(size(A,1),length(ts));
my5=zeros(size(A,1),length(ts));
my6=zeros(size(A,1),length(ts));

dmx1=zeros(size(A,1),length(ts));
for i=1:size(mx,2)
    temp=mx((i-1)*2*H+1:i*2*H,i);
    if i==1
        mx1(1,1)=temp(1);
        my1(1,1)=temp(2);
    end
    if i==2
        mx2(2,1)=temp(1);
        my2(2,1)=temp(2);
    end
    if i==3
        mx3(3,1)=temp(1);
        my3(3,1)=temp(2);
    end
    if i==4
        mx4(4,1)=temp(1);
        my4(4,1)=temp(2);
    end
    if i==5
        mx5(5,1)=temp(1);
        my5(5,1)=temp(2);
    end
    if i==6
        mx6(6,1)=temp(1);
        my6(6,1)=temp(2);
    end
    mx(:,i)=zeros(size(mx,1),1);
    mx((i-1)*2*H+1:i*2*H,i)=temp;


    temp=dmx((i-1)*2*H+1:i*2*H,1);
    if i==1
        dmx1(1,1)=temp(1);
    end
    dmx(:,i)=zeros(size(mx,1),1);
    dmx((i-1)*2*H+1:i*2*H,i)=temp;
end
while index<length(ts)
    index=index+1;
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
        if s == 1
            mx1(:,index)=mx(1:2*H:end,s);
            my1(:,index)=mx(2:2*H:end,s);
            dmx1(:,index)=dmx(1:2*H:end,s);
        end
        if s == 2
            mx2(:,index)=mx(1:2*H:end,s);
            my2(:,index)=mx(2:2*H:end,s);
        end
        if s == 3
            mx3(:,index)=mx(1:2*H:end,s);
            my3(:,index)=mx(2:2*H:end,s);
        end
        if s == 4
            mx4(:,index)=mx(1:2*H:end,s);
            my4(:,index)=mx(2:2*H:end,s);
        end
        if s == 5
            mx5(:,index)=mx(1:2*H:end,s);
            my5(:,index)=mx(2:2*H:end,s);
        end
        if s == 6
            mx6(:,index)=mx(1:2*H:end,s);
            my6(:,index)=mx(2:2*H:end,s);
        end
    end
    t=t+dt;
end
%%
figure(1)
grid on
set(get(handle(gcf),'JavaFrame'),'Maximized',true);
% set(gca,'LooseInset',get(gca,'TightInset'));
subplot(3,2,1);
plot(ts(1,:)',mx1(1,:)','linewidth',1.5);
hold on
plot(ts(2:end,:)',mx1(2:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_1}$','$\hat{p}_{x_1}^2$','$\hat{p}_{x_1}^3$','$\hat{p}_{x_1}^4$','$\hat{p}_{x_1}^5$','$\hat{p}_{x_1}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,2);
plot(ts(3,:)',mx2(2,:)','linewidth',1.5);
hold on
plot(ts(1:end,:)',mx2(1,:)','--','linewidth',1.5);
plot(ts(3:end,:)',mx2(3:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_2}$','$\hat{p}_{x_2}^1$','$\hat{p}_{x_2}^3$','$\hat{p}_{x_2}^4$','$\hat{p}_{x_2}^5$','$\hat{p}_{x_2}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,3);
plot(ts(3,:)',mx3(3,:)','linewidth',1.5);
hold on
plot(ts(1:2,:)',mx3(1:2,:)','--','linewidth',1.5);
plot(ts(4:end,:)',mx3(4:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_3}$','$\hat{p}_{x_3}^1$','$\hat{p}_{x_3}^2$','$\hat{p}_{x_3}^4$','$\hat{p}_{x_3}^5$','$\hat{p}_{x_3}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,4);
plot(ts(4,:)',mx4(4,:)','linewidth',1.5);
hold on
plot(ts(1:3,:)',mx4(1:3,:)','--','linewidth',1.5);
plot(ts(5:6,:)',mx4(5:6,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_4}$','$\hat{p}_{x_4}^1$','$\hat{p}_{x_4}^2$','$\hat{p}_{x_4}^3$','$\hat{p}_{x_4}^5$','$\hat{p}_{x_4}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,5);
plot(ts(5,:)',mx5(5,:)','linewidth',1.5);
hold on
plot(ts(1:4,:)',mx5(1:4,:)','--','linewidth',1.5);
plot(ts(6,:)',mx5(6,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_5}$','$\hat{p}_{x_5}^1$','$\hat{p}_{x_5}^2$','$\hat{p}_{x_5}^3$','$\hat{p}_{x_5}^4$','$\hat{p}_{x_5}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,6);
plot(ts(6,:)',mx6(6,:)','linewidth',1.5);
hold on
plot(ts(1:5,:)',mx6(1:5,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{x_6}$','$\hat{p}_{x_6}^1$','$\hat{p}_{x_6}^2$','$\hat{p}_{x_6}^3$','$\hat{p}_{x_6}^4$','$\hat{p}_{x_6}^5$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

axis auto
% axis tight




figure(2)
grid on
set(get(handle(gcf),'JavaFrame'),'Maximized',true);
% set(gca,'LooseInset',get(gca,'TightInset'));
subplot(3,2,1);
plot(ts(1,:)',my1(1,:)','linewidth',1.5);
hold on
plot(ts(2:end,:)',my1(2:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_1}$','$\hat{p}_{y_1}^2$','$\hat{p}_{y_1}^3$','$\hat{p}_{y_1}^4$','$\hat{p}_{y_1}^5$','$\hat{p}_{y_1}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,2);
plot(ts(3,:)',my2(2,:)','linewidth',1.5);
hold on
plot(ts(1:end,:)',my2(1,:)','--','linewidth',1.5);
plot(ts(3:end,:)',my2(3:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_2}$','$\hat{p}_{y_2}^1$','$\hat{p}_{y_2}^3$','$\hat{p}_{y_2}^4$','$\hat{p}_{y_2}^5$','$\hat{p}_{y_2}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,3);
plot(ts(3,:)',my3(3,:)','linewidth',1.5);
hold on
plot(ts(1:2,:)',my3(1:2,:)','--','linewidth',1.5);
plot(ts(4:end,:)',my3(4:end,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_3}$','$\hat{p}_{y_3}^1$','$\hat{p}_{y_3}^2$','$\hat{p}_{y_3}^4$','$\hat{p}_{y_3}^5$','$\hat{p}_{y_3}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,4);
plot(ts(4,:)',my4(4,:)','linewidth',1.5);
hold on
plot(ts(1:3,:)',my4(1:3,:)','--','linewidth',1.5);
plot(ts(5:6,:)',my4(5:6,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_4}$','$\hat{p}_{y_4}^1$','$\hat{p}_{y_4}^2$','$\hat{p}_{y_4}^3$','$\hat{p}_{y_4}^5$','$\hat{p}_{y_4}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,5);
plot(ts(5,:)',my5(5,:)','linewidth',1.5);
hold on
plot(ts(1:4,:)',my5(1:4,:)','--','linewidth',1.5);
plot(ts(6,:)',my5(6,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_5}$','$\hat{p}_{y_5}^1$','$\hat{p}_{y_5}^2$','$\hat{p}_{y_5}^3$','$\hat{p}_{y_5}^4$','$\hat{p}_{y_5}^6$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

subplot(3,2,6);
plot(ts(6,:)',my6(6,:)','linewidth',1.5);
hold on
plot(ts(1:5,:)',my6(1:5,:)','--','linewidth',1.5);
set(gca,'FontName','Times NewRoman','FontSize',13.5);
xlabel('$t$','Interpreter','latex');
% ylabel('$x$','Interpreter','latex');
legend({'$p_{y_6}$','$\hat{p}_{y_6}^1$','$\hat{p}_{y_6}^2$','$\hat{p}_{y_6}^3$','$\hat{p}_{y_6}^4$','$\hat{p}_{y_6}^5$'},'Interpreter','latex');
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');

% axis auto
axis tight
