%%==============================================================================
%% Run a Fair-Taylor (1983) algorithm to solve the DSGE model using actual technology series
%% Compute a weekly series for unemployment, and a weekly series for labor market tightness
%% All results saved as AER.mat
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%	Rev. by Pascal Michaillat on 2010-07-12: create weekly series to be consistent with calibration
%%	Rev. by Pascal Michaillat on 2010-08-19: new legend in graphs
%%	Rev. by Pascal Michaillat on 2011-01-06: HP-filter simulated series to make it comparable to empirical series
%%==============================================================================

clear all; close all;

global apos thpos npos mplpos hpos wpos Rpos ynum upos

%%%%%%%%%%%  Setup   %%%%%%%%%%%%%%%%%%%%%%%%%%%

setup_robustlow; data_1964_2009;
whp=10^5;%weight on hp filter

%%%%%%%%%%%  As initial guess, solve for stochastic equilibrium   %%%%%%%%%%%%%%%%%%%%%%%%%%%

[TH,TH0]=MCSOLVE(PI,A);

%%%%%%%%%%%  Position of variables   %%%%%%%%%%%%%%%%%%%%%%%%%%%

apos=1; 					% techno 
thpos   =  2;               % market tightness
npos   =  3;               % employment
upos   =  4;               % unemployment
mplpos  =  5;               % a*n^(alpha-1)
wpos	=6;					% w*a^gamma
Rpos   =  7;               % c*a/q(th)
hpos=8;						% hire
ynum=8;


%%%%%%%%%%%  Initial guess of solution in any state: use stochastic steady-state values -- ynum*ns  %%%%%%%%%%%%%%%%%%%%%%%%%%%

Y=zeros(ynum,ns);
Y(apos,:)=A;
Y(thpos,:)=TH;
Y(upos,:)=u(TH);
Y(npos,:)=(1-Y(upos,:))./(1-s);
Y(mplpos,:)=A.*Y(npos,:).^(alpha-1);
Y(wpos,:)=w.*A.^gamma;
Y(Rpos,:)=c.*A./q(TH);
Y(hpos,:)=s.*Y(npos,:);

%%%%%%%%%%%  Construct 3D array of expectation based on stochastic solutions -- ynum*ns*k1  %%%%%%%%%%%%%%%%%%%%%%%%%%%

k2=400;%sufficiently long horizon to cover type-III iterations
EA=EXPECTED_MC(PI,A,k2);% ns*k2
ETH=EXPECTED_MC(PI,TH,k2);
EY=zeros(ynum,ns,k2+1);%ynum*ns*k2
EY(apos,:,:)=EA;
EY(thpos,:,:)=ETH;
EY(upos,:,:)=u(ETH);
EY(hpos,:,:)=f(ETH).*u(ETH);
EY(wpos,:,:)=w.*EA.^gamma;
EN=(1-u(ETH))./(1-s);
EY(npos,:,:)=EN;
EY(mplpos,:,:)=alpha.*EA.*EN.^(alpha-1);
EY(Rpos,:,:)=c.*EA./q(ETH);

YLR=STEADYGE(w,gamma);%steady state

%%%%%%%%%%%  Run the Fair-Taylor algorithm   %%%%%%%%%%%%%%%%%%%%%%%%%%%

n0=(1-ux(1))./(1-s); %level of employment in data at t=-1
[WYt]=SIMULFT(TH,A,wamc,n0,EY,YLR);

Yt=WYt(:,1:12:end);%extract quarterly series from weekly series


%%%%%%%%%%%  Plot decomposition of unemployment obtained with FT   %%%%%%%%%%%%%%%%%%%%%%%%%%%

At=Yt(apos,:);
Ut=Yt(upos,:);
ut0=hpfilter(log(Ut),whp);
ut1=exp(ut0);
Uthp=nairu.*ut1;
THt=Yt(thpos,:);
URt=max(1-((alpha./w).^(1./(1-alpha)).*At.^((1-gamma)./(1-alpha))),0);
%URt=ur(At);
UFt=Ut-URt;

YY=[UFt',URt'];
xt=[1,1+4.*10,1+4.*20,1+4.*30,1+4.*40];%plot on 1964--2009 period
xx=[1:nsample];

figure(1)
clf
harea=area(xx,YY);
set(get(harea(1),'Children'),'FaceColor',[.5 .9 .6],...
             'EdgeColor','k',...
             'LineWidth',3)
set(get(harea(2),'Children'),'FaceColor',[0 0 1],...
               'EdgeColor','k',...
               'LineWidth',3)
ylabel('Unemployment rate','FontSize',22)
ylim([0,.12])
set(gca,'Layer','top')
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
set(gca,'FontSize',22)
gtext('\leftarrow Rationing unemp.','FontSize',22)
gtext('Frictional unemp.','FontSize',22)
print('-depsc','graph/DECOFTrobustlow.eps')

%%%%%%%%%%%  Compare actual and predicted unemployment   %%%%%%%%%%%%%%%%%%%%%%%%%%%
pas=182; 

figure(3)
 clf
 plot(Uthp,'--r','LineWidth',4)
 hold on
 plot(ux,'-b','LineWidth',4)
 ylabel('Unemployment rate','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
 ylim([0,0.12])
 xlim([1,pas])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Simulated','Actual')
 set(h_legend,'FontSize',22,'Location','NorthWest');  
 print('-depsc','graph/UFTHProbustlow.eps')


 figure(13)
 clf
 plot(ux,'-b','LineWidth',4)
 hold on
 plot(Ut,'--r','LineWidth',4)
 ylabel('Unemployment rate','FontSize',22)
 set(gca,'YGrid','on','XGrid','on','FontSize',22)
 ylim([0,0.12])
 xlim([1,pas])
 set(gca,'XTick',xt)
 set(gca,'XTickLabel','1964|1974|1984|1994|2004')
 h_legend=legend('Actual','Simulated')
 set(h_legend,'FontSize',22,'Location','NorthWest');  
 print('-depsc','graph/UFTrobustlow.eps')

save 'AERrobustlow.mat'