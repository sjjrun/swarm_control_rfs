close all
load("data_sigma.mat");

num_surf=200;
[X,Y]=meshgrid(linspace(x(1), x(2), num_surf),linspace(y(1)-5, y(2)+5, num_surf/2));
Z=zeros(num_surf/2,num_surf);

figure
set(get(handle(gcf),'JavaFrame'),'Maximized',true);
% set(gca,'LooseInset',get(gca,'TightInset'));
% set(gcf,'OuterPosition',get(0,'ScreenSize'));
f=getframe(gcf);
imind=frame2im(f);
[imind,cm] = rgb2ind(imind,256);
imwrite(imind,cm,'pic_sigma.gif','gif', 'Loopcount',inf,'DelayTime',1);

for k=1:50
    obj = gmdistribution(m((k-1)*2+1:k*2,:)',diag([1 1]),max(w(k,:),0.001*ones(1,length(wk))));
    Fun=@(x,y)pdf(obj,[x y]);
    PDFj=reshape(Fun(reshape(X,num_surf/2*num_surf,1),reshape(Y,num_surf/2*num_surf,1)),num_surf/2,num_surf);
    rng(4);
    follow_node=random(obj,54);
    %     contour(X,Y,PDFj,linspace(0.001, max(max(PDFj)), 3));
    if k~=1
        plot(m(1:2:2*k-1,:),m(2:2:2*k,:),'--','linewidth',1);
    end
    hold on;
    contour(X,Y,PDFj,[0.0005, 0.0005],'--k');
    scatter(md(1,:),md(2,:), 200, 'rx','linewidth',1.5);
    scatter(follow_node(:,1),follow_node(:,2),5,'k', 'filled');
%     scatter(m((k-1)*2+1,:),m(k*2,:), 50, '^k', 'filled');
    theta = linspace(0,2*pi);
    for i=1:size(mc,2)
        xc = dc(i)*cos(theta) + mc(1,i);
        yc = dc(i)*sin(theta) + mc(2,i);
        plot(xc,yc,'r','linewidth',1.5);
    end
    axis([x(1) x(2) y(1)-5 y(2)+5]);
    axis equal
    set(gca,'FontName','Times NewRoman','FontSize',20);
    xlabel('$p_x$','Interpreter','latex');
    ylabel('$p_y$','Interpreter','latex');
    title('Trajectories of multiple Sub-Swarms with $D_{\sigma}$','Interpreter','latex')
    hold off;

    f=getframe(gcf);
    imind=frame2im(f);
    [imind,cm] = rgb2ind(imind,256);
    imwrite(imind,cm,'pic_sigma.gif','gif','WriteMode','append','DelayTime',1);
end

%%
k=25;
figure(1)
% set(get(handle(gcf),'JavaFrame'),'Maximized',true);
set(gca,'LooseInset',get(gca,'TightInset'));
obj = gmdistribution(m((k-1)*2+1:k*2,:)',diag([1 1]),max(w(k,:),0.001*ones(1,length(wk))));
Fun=@(x,y)pdf(obj,[x y]);
PDFj=reshape(Fun(reshape(X,num_surf/2*num_surf,1),reshape(Y,num_surf/2*num_surf,1)),num_surf/2,num_surf);
rng(4);
follow_node=random(obj,54);
if k~=1
    plot(m(1:2:2*k-1,:),m(2:2:2*k,:),'--','linewidth',1.5);
end
hold on;
contour(X,Y,PDFj,[0.0005, 0.0005],'--k');
scatter(md(1,:),md(2,:), 200, 'rx','linewidth',1.5);
scatter(follow_node(:,1),follow_node(:,2),5,'k', 'filled');
% scatter(m((k-1)*2+1,:),m(k*2,:), 50, '^k', 'filled');
theta = linspace(0,2*pi);
for i=1:size(mc,2)
    xc = dc(i)*cos(theta) + mc(1,i);
    yc = dc(i)*sin(theta) + mc(2,i);
    plot(xc,yc,'r','linewidth',1.5);
end
% axis([x(1) x(2) y(1) y(2)]);
axis equal
set(gca,'FontName','Times NewRoman','FontSize',15);
xlabel('$p_x$','Interpreter','latex');
ylabel('$p_y$','Interpreter','latex');
% title('Trajectories of 6 Sub-Swarms','Interpreter','latex');
% title('The Initial Conditions of Swarms','Interpreter','latex');

%%
ts=1:1:kmax;
ts=kron(ones(length(wk),1),ts);
figure(2)
grid on
set(get(handle(gcf),'JavaFrame'),'Maximized',true);
set(gca,'LooseInset',get(gca,'TightInset'));
subplot(2,1,1);
plot(ts',dm(1:2:end-1,:),'linewidth',3);
set(gca,'FontName','Times NewRoman','FontSize',22);
axis([0 100 -5 5]);
xticks([linspace(0, 100,5)]);
yticks([-5 0 5]);
% xlabel('$t$','Interpreter','latex');
ylabel('$q_x$','Interpreter','latex');
legend({'$q_{x_1}$','$q_{x_2}$','$q_{x_3}$','$q_{x_4}$','$q_{x_5}$','$q_{x_6}$'},'Interpreter','latex');
% title('The Observer Value of multiple sub-swarms','Interpreter','latex');


subplot(2,1,2);
plot(ts',dm(2:2:end,:),'linewidth',3);
set(gca,'FontName','Times NewRoman','FontSize',22);
axis([0 100 -5 5]);
xticks([linspace(0, 100,5)]);
yticks([-5 0 5]);
xlabel('$t$','Interpreter','latex');
ylabel('$q_y$','Interpreter','latex');
legend({'$q_{y_1}$','$q_{y_2}$','$q_{y_3}$','$q_{y_4}$','$q_{y_5}$','$q_{y_6}$'},'Interpreter','latex');
% title('$\alpha=0$','Interpreter','latex');
% title('The Observer Value of $q_{x_1}$','Interpreter','latex');
% axis auto


%%
ts=1:1:kmax;
ts=kron(ones(length(wk),1),ts);
figure(2)
grid on
set(get(handle(gcf),'JavaFrame'),'Maximized',true);
% set(gca,'LooseInset',get(gca,'TightInset'));
subplot(2,1,1);
plot(ts',u(1:2:end-1,:),'linewidth',3);
set(gca,'FontName','Times NewRoman','FontSize',22);
xlabel('$t$','Interpreter','latex');
ylabel('$u_x$','Interpreter','latex');
legend({'$u_{x_1}$','$u_{x_2}$','$u_{x_3}$','$u_{x_4}$','$u_{x_5}$','$u_{x_6}$'},'Interpreter','latex');
axis([0 100 -3 5]);
xticks([linspace(0, 100,5)]);
yticks([-3 0 5]);
% title('The Observer Value of $p_{x_1}$','Interpreter','latex');


subplot(2,1,2);
plot(ts',u(2:2:end,:),'linewidth',3);
set(gca,'FontName','Times NewRoman','FontSize',22);
xlabel('$t$','Interpreter','latex');
ylabel('$u_y$','Interpreter','latex');
legend({'$u_{y_1}$','$u_{y_2}$','$u_{y_3}$','$u_{y_4}$','$u_{y_5}$','$u_{y_6}$'},'Interpreter','latex');
axis([0 100 -3 5]);
xticks([linspace(0, 100,5)]);
yticks([-3 0 5]);
% title('$\alpha=0$','Interpreter','latex');
% title('The Observer Value of $q_{x_1}$','Interpreter','latex');
% axis auto 