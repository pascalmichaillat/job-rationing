U_stoch=u(TH(amc));
U_ss=u(TH0(amc));
U_exact=CREATEU(THt,n0);


figure(14)
clf
plot(U_exact,'b','LineWidth',4)
hold on
plot(U_stoch,'--red','LineWidth',4)
plot(U_ss,':','Color',[0,0.5,0],'LineWidth',4)
set(gca,'YGrid','on')
set(gca,'XGrid','on')
set(gca,'FontSize',22)
xlim([0,182])
ylabel('Unemployment rate','FontSize',22)
set(gca,'XTick',xt)
set(gca,'XTickLabel','1964|1974|1984|1994|2004')
h_legend=legend('Exact solution','Stochastic steady states','Steady states')
set(h_legend,'FontSize',22);  
print('-depsc','graph/compareU.eps')