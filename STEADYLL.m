%%=================================================================
%%Compute steady state of decentralized economy for simulations of log-linear model
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%=================================================================
function [W_bar,C_bar,TH_bar,N_bar,H_bar,U_bar,UC_bar,UF_bar,Y_bar]=STEADYLL(w,gamma)

global delta eta c a alpha omega s z q f u ur

%theta in steady-state in both cases
TH_bar=FINDTH(w,gamma);

%derive other steady-state values
U_bar=u(TH_bar);
N_bar=(1-U_bar)./(1-s);
H_bar=s*N_bar;
Y_bar=a.*N_bar.^alpha;
C_bar=Y_bar-H_bar*c*a./q(TH_bar);
W_bar=w.*a^gamma;
UC_bar=ur(a);
UF_bar=U_bar-UC_bar;

