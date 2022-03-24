%%==============================================================================
%% Compute IRFs of log-linearized DSGE model with job rationing and matching frictions
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%	Rev. by Pascal Michaillat on 2011-01-08: Modify to reduce the number of IRFs displayed to 8: a,Y,W,H,TH,U,UR,UF
%%==============================================================================

clear all;close all;
setupsimul;
T=400;%length of IRF

%%===================================================================   Compute IRFs 

shock=zeros(xeq,1);
shock(a_pos)=-sigma_a;
imptech=BMAT*shock;
for i=2:T
    imptech=[imptech AMAT*imptech(:,i-1)];% use reduced form solution: x_t=amat*x_{t-1}+b*shock
end

%%%%%%%%%%%  include UC and UF   %%%%%%%%%%%%%%%%%%%%%%%%%%%

StS=SS(1:xvari);
ucpos=xvari+1;ufpos=xvari+2;
StS(ucpos,1)=UC_bar;
StS(ufpos,1)=UF_bar;

IRF=imptech(1:xvari,:);%store impulse responses
IRF=[IRF;-IRF(apos,:).*(1-gamma)./(1-alpha).*(1-UC_bar)./UC_bar];
IRF=[IRF;U_bar./UF_bar.*IRF(upos,:)-UC_bar./UF_bar.*IRF(end,:)];

elast_ua=max(abs(IRF(thpos,:))./abs(IRF(apos,:)));%elasticity of theta with respect to a

%%=============================================================      Plot IRFs  


top=250;
rang=[1:top];
gra=[apos,ypos,wpos,hpos,thpos,upos,9,10]; 
nam={'Technology','Output','Wage','Number of hires','Vacancy-unemployment ratio','Unemployment','Rationing unemployment','Frictional unemployment'};
ba=[1,Y_bar,W_bar,H_bar,TH_bar,U_bar,UC_bar,UF_bar];
la=[-0.0035,-0.0035,-0.0035,-0.025,-0.04,0,0,-0.12];
ma=[0,0,0,0.001,0,0.02,0.12,0];
%plot
figure(1)
clf
for j=1:8
  subplot(4,2,j)
  plot(rang,IRF(gra(j),rang),'--r','LineWidth',3)
  set(gca,'YGrid','on','XTickLabel','','FontSize',14)
  xlim([0 top]) ;
  ylim([la(j) ma(j)]);
  title(nam{j},'FontSize',14)
end
%print('-depsc','graph/IRF8.eps')

