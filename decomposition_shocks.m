%%==============================================================================
%%  Back-out shocks to match data exactly, and compute decomposition accordingly
%% for simplicity: abstract from dynamics (turnover dynamics do not matter, recruiting dynamics are not very important)
%%	Created by Pascal Michaillat, London School of Economics on 2011-01-23
%%==============================================================================

%%====================================================================     Setup
calibration;
bayesdata;%interesting weekly data: anl, unl, nnl, thnl, wnl
nam='31janv';
xt=[1,1+4.*10,1+4.*20,1+4.*30,1+4.*40];%plot on 1964--2009 period
xx=[1:182];

fth=@(n,omega)(1./omega.*s.*n./(1-(1-s).*n)).^(1./(1-eta));
ur2=@(ax,wx)max(1-(wx./(alpha.*ax)).^(-1./(1-alpha)),0);

%%===================================     Backout technology to match employment
nx=nnl;
ux=unl;
thx=fth(nx,omega);
ay=((alpha.*nx.^(alpha-1)-r.*c./q(thx))./w0).^(1./(gamma-1));
ury=ur(ay);ufy=ux-ury;


%%%%%%%%%%%  plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%
UFt=ufy(1:12:end);
URt=ury(1:12:end);


YY=[UFt',URt'];

figure(10)
clf
harea=area(xx,YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.1])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc',['graph/deco1',nam,'.eps'])

figure(11)
 clf
 plot(ay(1:12:end),'--r','LineWidth',4)
 hold on
 plot(anl(1:12:end),'-b','LineWidth',4)
 ylabel('Technology','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,182])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Estimated','Actual')
 set(h_legend,'FontSize',22);  
 print('-depsc',['graph/shocka',nam,'.eps'])


%%===================     Backout wage shocks, given that technology is observed
ax=anl;
wy=alpha.*ax.*nx.^(alpha-1)-r.*c.*ax./q(thx);
ury=ur2(ax,wy);ufy=ux-ury;


%%%%%%%%%%%  plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%
UFt=ufy(1:12:end);
URt=ury(1:12:end);


YY=[UFt',URt'];

figure(12)
clf
harea=area(xx,YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.1])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc',['graph/deco2',nam,'.eps'])

figure(13)
 clf
 plot(wy(1:12:end),'--r','LineWidth',4)
 hold on
 plot(wnl(1:12:end),'-b','LineWidth',4)
 ylabel('Wage','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,182])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Estimated','Actual')
 set(h_legend,'FontSize',22);  
 print('-depsc',['graph/shockw',nam,'.eps'])


figure(15)
 clf
 plot(wy(end-34.*12+1:12:end),'--r','LineWidth',4)
 hold on
 plot(wnl(end-34.*12+1:12:end),'-b','LineWidth',4)
 plot(ecirwx,'.-m','LineWidth',4)
 ylabel('Wage','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,34])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Estimated','CPS','ECI')
 set(h_legend,'FontSize',22);  
 print('-depsc',['graph/shockeciw',nam,'.eps'])



%%===================     Backout matching shocks, given that technology and wages are observed
nx=nnl;
ux=unl;
thx=fth(nx,omega);
ax=anl;
wx=eciwnl;
ax=ax(end-33.*12:end);
nx=nx(end-33.*12:end);
thx=thx(end-33.*12:end);
ux=ux(end-33.*12:end);
omegay=((alpha.*ax.*nx.^(alpha-1)-wx)./(r.*c.*ax.*thx.^eta)).^(-1);
ury=ur2(ax,wx);ufy=ux-ury;


%%%%%%%%%%%  plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%
UFt=ufy(1:12:end);
URt=ury(1:12:end);


YY=[UFt',URt'];

figure(14)
clf
harea=area([1:34],YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.1])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
%set(gca,'XTick',xt)
%set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc',['graph/deco3',nam,'.eps'])

%thd=thnl(1:12:end);
%nnlp=(1-unl)./(1-s);
%hnl=nnl-(1-s).*nnlp;
%fnl=hnl./unl;fd=fnl(1:12:end);
%kappad=fd./f(thd');
%omegax=omega.*kappad;

figure(15)
 clf
 plot(omegay(1:12:end),'--r','LineWidth',4)
% hold on
% plot(omegax,'-b','LineWidth',4)
 ylabel('Matching efficiency','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,182])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Estimated','Actual')
 set(h_legend,'FontSize',22);  
 print('-depsc',['graph/shockomega',nam,'.eps'])



%%===================     Backout matching shocks, given that technology is observed
ax=anl;
wx=w0.*ax.^gamma;
omegay=((alpha.*ax.*nx.^(alpha-1)-wx)./(r.*c.*ax.*thx.^eta)).^(-1);
ury=ur2(ax,wx);ufy=ux-ury;


%%%%%%%%%%%  plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%
UFt=ufy(1:12:end);
URt=ury(1:12:end);


YY=[UFt',URt'];

figure(12)
clf
harea=area(xx,YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.1])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc',['graph/deco4',nam,'.eps'])

omegad=(s.*nnl./unl).*thnl.^(eta-1);

%nnlp=(1-unl)./(1-s);
%hnl=nnl-(1-s).*nnlp;
%fnl=hnl./unl;fd=fnl(1:12:end);
%kappad=fd./f(thd');
%omegax=omega.*kappad;


figure(13)
 clf
% plot(omegay(1:12:end),'--r','LineWidth',4)
% hold on
 plot(omegad(1:12:end),'-b','LineWidth',4)
 ylabel('Matching efficiency','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,182])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
% h_legend=legend('Estimated','Actual')
% set(h_legend,'FontSize',22,'Location','NorthWest');  
 print('-depsc',['graph/shockomega3',nam,'.eps'])


%%===================     Backout wage shocks, given that technology and matching are observed
omegad=(s.*nnl./unl).*thnl.^(eta-1);
omegax=omegad;
thx=fth(nx,omegax);
wy=(alpha.*ax.*nx.^(alpha-1))-(r.*c.*ax./omegax.*thx.^eta);
ury=ur2(ax,wy);ufy=ux-ury;


%%%%%%%%%%%  plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%
UFt=ufy(1:12:end);
URt=ury(1:12:end);


YY=[UFt',URt'];

figure(14)
clf
harea=area(xx,YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.1])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc',['graph/deco5',nam,'.eps'])

figure(13)
 clf
 plot(wy(1:12:end),'--r','LineWidth',4)
 hold on
 plot(wnl(1:12:end),'-b','LineWidth',4)
 ylabel('Wage','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
% ylim([0.9,1.1])
 xlim([1,182])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Estimated','Actual')
 set(h_legend,'FontSize',22);  
 print('-depsc',['graph/shockw2',nam,'.eps'])